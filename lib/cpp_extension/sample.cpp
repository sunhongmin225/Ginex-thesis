#include <stdlib.h>
#include <fcntl.h>
#include <torch/extension.h>
#include <Python.h>
#include <pybind11/pybind11.h>
#include <torch/script.h>
#include <errno.h>
#include <cstring>
#include <inttypes.h>
#include <omp.h>
#include <stdio.h>
extern "C" {
    #include "lz4.h"
}
#include <vector>
#define ALIGNMENT 4096

// return start index of buffer
int64_t load_neighbors_into_buffer(int col_fd, int64_t row_start, int64_t row_count, int64_t* buffer){
// int32_t load_neighbors_into_buffer(int col_fd, int32_t row_start, int32_t row_count, int32_t* buffer){
    int64_t size = (row_count*sizeof(int64_t) + 2*ALIGNMENT)&(long)~(ALIGNMENT-1);
    // int32_t size = (row_count*sizeof(int32_t) + 2*ALIGNMENT)&(int)~(ALIGNMENT-1);
    int64_t offset = row_start*sizeof(int64_t);
    // int32_t offset = row_start*sizeof(int32_t);
    int64_t aligned_offset = offset&(long)~(ALIGNMENT-1);
    // int32_t aligned_offset = offset&(int)~(ALIGNMENT-1);

    if(pread(col_fd, buffer, size, aligned_offset) == -1){
        fprintf(stderr, "ERROR: %s\n", strerror(errno));
    }

    return (offset-aligned_offset)/sizeof(int64_t);
    // return (offset-aligned_offset)/sizeof(int32_t);
}

std::tuple<int64_t*, int64_t*, int64_t> get_new_neighbor_buffer(int64_t row_count){
// std::tuple<int32_t*, int32_t*, int32_t> get_new_neighbor_buffer(int32_t row_count){
    int64_t size = (row_count*sizeof(int64_t) + 3*ALIGNMENT)&(long)~(ALIGNMENT-1);
    // int32_t size = (row_count*sizeof(int32_t) + 3*ALIGNMENT)&(int)~(ALIGNMENT-1);
    int64_t* neighbor_buffer = (int64_t*)malloc(size + ALIGNMENT);
    // int32_t* neighbor_buffer = (int32_t*)malloc(size + ALIGNMENT);
    int64_t* aligned_neighbor_buffer = (int64_t*)(((long)neighbor_buffer+(long)ALIGNMENT)&(long)~(ALIGNMENT-1));
    // int32_t* aligned_neighbor_buffer = (int32_t*)(((long)neighbor_buffer+(int)ALIGNMENT)&(int)~(ALIGNMENT-1));

    return std::make_tuple(neighbor_buffer, aligned_neighbor_buffer, size/sizeof(int64_t));
    // return std::make_tuple(neighbor_buffer, aligned_neighbor_buffer, size/sizeof(int32_t));
}

std::tuple<torch::Tensor, torch::Tensor, torch::Tensor, torch::Tensor, int, int>
sample_adj_ginex(torch::Tensor rowptr, std::string col_file, torch::Tensor idx, 
                  torch::Tensor cache, torch::Tensor cache_table,
                  int64_t num_neighbors, bool replace) {
                  // int32_t num_neighbors, bool replace) {

  srand(time(NULL) + 1000 * getpid()); // Initialize random seed.

  // open file
  int col_fd = open(col_file.c_str(), O_RDONLY | O_DIRECT);

  // prepare buffer
  int64_t neighbor_buffer_size = 1<<15;
  // int32_t neighbor_buffer_size = 1<<15;
  int64_t* neighbor_buffer = (int64_t*)malloc(neighbor_buffer_size*sizeof(int64_t) + 2*ALIGNMENT);
  // int32_t* neighbor_buffer = (int32_t*)malloc(neighbor_buffer_size*sizeof(int32_t) + 2*ALIGNMENT);
  int64_t* aligned_neighbor_buffer = (int64_t*)(((long)neighbor_buffer+(long)ALIGNMENT)&(long)~(ALIGNMENT-1));
  // int32_t* aligned_neighbor_buffer = (int32_t*)(((long)neighbor_buffer+(int)ALIGNMENT)&(int)~(ALIGNMENT-1));

  auto rowptr_data = rowptr.data_ptr<int64_t>();
  // auto rowptr_data = rowptr.data_ptr<int32_t>();
  auto idx_data = idx.data_ptr<int64_t>();
  // auto idx_data = idx.data_ptr<int32_t>();
  auto cache_data = cache.data_ptr<int64_t>();
  // auto cache_data = cache.data_ptr<int32_t>();
  auto cache_table_data = cache_table.data_ptr<int64_t>();
  // auto cache_table_data = cache_table.data_ptr<int32_t>();

  auto out_rowptr = torch::empty(idx.numel() + 1, idx.options());
  auto out_rowptr_data = out_rowptr.data_ptr<int64_t>();
  // auto out_rowptr_data = out_rowptr.data_ptr<int32_t>();
  out_rowptr_data[0] = 0;

  std::vector<std::vector<std::tuple<int64_t, int64_t>>> cols; // col, e_id
  // std::vector<std::vector<std::tuple<int32_t, int32_t>>> cols; // col, e_id
  std::vector<int64_t> n_ids;
  // std::vector<int32_t> n_ids;
  std::unordered_map<int64_t, int64_t> n_id_map;
  // std::unordered_map<int32_t, int32_t> n_id_map;

  int num_hit = 0;
  int num_miss = 0;

  int64_t i;
  // int32_t i;
  for (int64_t n = 0; n < idx.numel(); n++) {
  // for (int32_t n = 0; n < idx.numel(); n++) {
    i = idx_data[n];
    cols.push_back(std::vector<std::tuple<int64_t, int64_t>>());
    // cols.push_back(std::vector<std::tuple<int32_t, int32_t>>());
    n_id_map[i] = n;
    n_ids.push_back(i);
  }

  int64_t n, c, e, row_start, row_end, row_count;
  // int32_t n, c, e, row_start, row_end, row_count;
  int64_t start_offset;
  // int32_t start_offset;
  int64_t cache_entry;
  // int32_t cache_entry;

  if (num_neighbors < 0) { // Full neighbor sampling ======================================

    for (int64_t i = 0; i < idx.numel(); i++) {
    // for (int32_t i = 0; i < idx.numel(); i++) {
      n = idx_data[i];
      cache_entry = cache_table_data[n];
      if (cache_entry >= 0){
          row_count = cache_data[cache_entry];
          for (int64_t j = 0; j < row_count; j++){
          // for (int32_t j = 0; j < row_count; j++){
            e = cache_entry + 1 + j;
            c = cache_data[e];

            // if c does not exist in n_id_map
            if (n_id_map.count(c) == 0) {
              n_id_map[c] = n_ids.size();
              n_ids.push_back(c);
            }
            cols[i].push_back(std::make_tuple(n_id_map[c], rowptr_data[n] + j));
          }
      }
      else {
          row_start = rowptr_data[n], row_end = rowptr_data[n + 1];
          row_count = row_end - row_start;

          if (row_count > neighbor_buffer_size){
              free(neighbor_buffer);
              std::tie(neighbor_buffer, aligned_neighbor_buffer, neighbor_buffer_size) = get_new_neighbor_buffer(row_count);
          }

          start_offset = load_neighbors_into_buffer(col_fd,  row_start, row_count, aligned_neighbor_buffer);
          for (int64_t j = 0; j < row_count; j++) {
          // for (int32_t j = 0; j < row_count; j++) {
            e = start_offset + j;
            c = aligned_neighbor_buffer[e];

            // if c does not exist in n_id_map
            if (n_id_map.count(c) == 0) {
              n_id_map[c] = n_ids.size();
              n_ids.push_back(c);
            }
            cols[i].push_back(std::make_tuple(n_id_map[c], row_start + j));
          }
      }
      out_rowptr_data[i + 1] = out_rowptr_data[i] + cols[i].size();
    }
  }
 /// 
  else if (replace) { // Sample with replacement ===============================

    for (int64_t i = 0; i < idx.numel(); i++) {
    // for (int32_t i = 0; i < idx.numel(); i++) {
      n = idx_data[i];
      cache_entry = cache_table_data[n];
      if (cache_entry >= 0){
          row_count = cache_data[cache_entry];
          for (int64_t j = 0; j < num_neighbors; j++){
          // for (int32_t j = 0; j < num_neighbors; j++){
            e = cache_entry + 1 + rand() % row_count;
            c = cache_data[e];

            // if c does not exist in n_id_map
            if (n_id_map.count(c) == 0) {
              n_id_map[c] = n_ids.size();
              n_ids.push_back(c);
            }
            cols[i].push_back(std::make_tuple(n_id_map[c], rowptr_data[n] + j));
          }
      }
      else {
          row_start = rowptr_data[n], row_end = rowptr_data[n + 1];
          row_count = row_end - row_start;

          if (row_count > neighbor_buffer_size){
              free(neighbor_buffer);
              std::tie(neighbor_buffer, aligned_neighbor_buffer, neighbor_buffer_size) = get_new_neighbor_buffer(row_count);
          }
          if (row_count > 0) {
            start_offset = load_neighbors_into_buffer(col_fd,  row_start, row_count, aligned_neighbor_buffer);
            for (int64_t j = 0; j < num_neighbors; j++) {
            // for (int32_t j = 0; j < num_neighbors; j++) {
              e = start_offset + rand() % row_count;
              c = aligned_neighbor_buffer[e];

              if (n_id_map.count(c) == 0) {
                n_id_map[c] = n_ids.size();
                n_ids.push_back(c);
              }
              cols[i].push_back(std::make_tuple(n_id_map[c], row_start + j));
            }
          }
      }
      out_rowptr_data[i + 1] = out_rowptr_data[i] + cols[i].size();
    }

  } else { // Sample without replacement via Robert Floyd algorithm ============

    for (int64_t i = 0; i < idx.numel(); i++) {
    // for (int32_t i = 0; i < idx.numel(); i++) {
      n = idx_data[i];
      cache_entry = cache_table_data[n];
      if (cache_entry >= 0){
          num_hit++;
          row_count = cache_data[cache_entry];
          if (row_count > 0){
              std::unordered_set<int64_t> perm;
              // std::unordered_set<int32_t> perm;
              if (row_count <= num_neighbors) {
                for (int64_t j = 0; j < row_count; j++)
                // for (int32_t j = 0; j < row_count; j++)
                  perm.insert(j);
              } 
              else {
                for (int64_t j = row_count - num_neighbors; j < row_count; j++) {
                // for (int32_t j = row_count - num_neighbors; j < row_count; j++) {
                  if (!perm.insert(rand() % j).second)
                    perm.insert(j);
                }
              }

              for (const int64_t &p : perm) {
              // for (const int32_t &p : perm) {
                e = cache_entry + 1 + p;
                c = cache_data[e];

                if (n_id_map.count(c) == 0) {
                  n_id_map[c] = n_ids.size();
                  n_ids.push_back(c);
                }
                cols[i].push_back(std::make_tuple(n_id_map[c], rowptr_data[n] + p));
                //cols[i].push_back(std::make_tuple(n_id_map[c], e));
              }
          }
      }
      else {
          num_miss++;
          row_start = rowptr_data[n], row_end = rowptr_data[n + 1];
          row_count = row_end - row_start;

          if (row_count > neighbor_buffer_size){
              free(neighbor_buffer);
              std::tie(neighbor_buffer, aligned_neighbor_buffer, neighbor_buffer_size) = get_new_neighbor_buffer(row_count);
          }

          if (row_count > 0){
              start_offset = load_neighbors_into_buffer(col_fd,  row_start, row_count, aligned_neighbor_buffer);

              std::unordered_set<int64_t> perm;
              // std::unordered_set<int32_t> perm;
              if (row_count <= num_neighbors) {
                for (int64_t j = 0; j < row_count; j++)
                // for (int32_t j = 0; j < row_count; j++)
                  perm.insert(j);
              } 
              else {
                for (int64_t j = row_count - num_neighbors; j < row_count; j++) {
                // for (int32_t j = row_count - num_neighbors; j < row_count; j++) {
                  if (!perm.insert(rand() % j).second)
                    perm.insert(j);
                }
              }

              for (const int64_t &p : perm) {
              // for (const int32_t &p : perm) {
                e = start_offset + p;
                c = aligned_neighbor_buffer[e];

                if (n_id_map.count(c) == 0) {
                  n_id_map[c] = n_ids.size();
                  n_ids.push_back(c);
                }
                cols[i].push_back(std::make_tuple(n_id_map[c], row_start + p));
              }
          }
      }
      out_rowptr_data[i + 1] = out_rowptr_data[i] + cols[i].size();
    }
  }
 ///

  int64_t N = n_ids.size();
  // int32_t N = n_ids.size();
  auto out_n_id = torch::from_blob(n_ids.data(), {N}, idx.options()).clone();

  int64_t E = out_rowptr_data[idx.numel()];
  // int32_t E = out_rowptr_data[idx.numel()];
  auto out_col = torch::empty(E, idx.options());
  auto out_col_data = out_col.data_ptr<int64_t>();
  // auto out_col_data = out_col.data_ptr<int32_t>();
  auto out_e_id = torch::empty(E, idx.options());
  auto out_e_id_data = out_e_id.data_ptr<int64_t>();
  // auto out_e_id_data = out_e_id.data_ptr<int32_t>();

  i = 0;
  for (std::vector<std::tuple<int64_t, int64_t>> &col_vec : cols) {
  // for (std::vector<std::tuple<int32_t, int32_t>> &col_vec : cols) {
    std::sort(col_vec.begin(), col_vec.end(),
              [](const std::tuple<int64_t, int64_t> &a,
              // [](const std::tuple<int32_t, int32_t> &a,
                 const std::tuple<int64_t, int64_t> &b) -> bool {
                 // const std::tuple<int32_t, int32_t> &b) -> bool {
                return std::get<0>(a) < std::get<0>(b);
              });
    for (const std::tuple<int64_t, int64_t> &value : col_vec) {
    // for (const std::tuple<int32_t, int32_t> &value : col_vec) {
      out_col_data[i] = std::get<0>(value);
      out_e_id_data[i] = std::get<1>(value);
      i += 1;
    }
  }

  free(neighbor_buffer);
  close(col_fd);

  // float hit_ratio = (float) num_hit / (float) (num_hit + num_miss);
  // printf("arcmsh::num_hit = %d, num_miss = %d, hit_ratio = %f\n", num_hit, num_miss, hit_ratio);

  return std::make_tuple(out_rowptr, out_col, out_n_id, out_e_id, num_hit, num_miss);
}

torch::Tensor
get_neighbors(torch::Tensor rowptr, std::string col_file, torch::Tensor idx) {

  // open files
  int col_fd = open(col_file.c_str(), O_RDONLY | O_DIRECT);

  // prepare buffer
  int64_t neighbor_buffer_size = 1<<15;
  // int32_t neighbor_buffer_size = 1<<15;
  int64_t* neighbor_buffer = (int64_t*)malloc(neighbor_buffer_size*sizeof(int64_t) + 2*ALIGNMENT);
  // int32_t* neighbor_buffer = (int32_t*)malloc(neighbor_buffer_size*sizeof(int32_t) + 2*ALIGNMENT);
  int64_t* aligned_neighbor_buffer = (int64_t*)(((long)neighbor_buffer+(long)ALIGNMENT)&(long)~(ALIGNMENT-1));
  // int32_t* aligned_neighbor_buffer = (int32_t*)(((long)neighbor_buffer+(int)ALIGNMENT)&(int)~(ALIGNMENT-1));

  auto rowptr_data = rowptr.data_ptr<int64_t>();
  // auto rowptr_data = rowptr.data_ptr<int32_t>();
  auto idx_data = idx.data_ptr<int64_t>()[0];
  // auto idx_data = idx.data_ptr<int32_t>()[0];

  std::vector<int64_t> n_ids;
  // std::vector<int32_t> n_ids;

  int64_t i;
  // int32_t i;

  int64_t n, c, e, row_start, row_end, row_count;
  // int32_t n, c, e, row_start, row_end, row_count;
  int64_t start_offset;
  // int32_t start_offset;

  row_start = rowptr_data[idx_data], row_end = rowptr_data[idx_data + 1]; 
  row_count = row_end - row_start;

  if (row_count > neighbor_buffer_size){
      free(neighbor_buffer);
      std::tie(neighbor_buffer, aligned_neighbor_buffer, neighbor_buffer_size) = get_new_neighbor_buffer(row_count);
  }

  start_offset = load_neighbors_into_buffer(col_fd,  row_start, row_count, aligned_neighbor_buffer);
  for (int64_t j = 0; j < row_count; j++) {
  // for (int32_t j = 0; j < row_count; j++) {
    e = start_offset + j;
    c = aligned_neighbor_buffer[e];
    n_ids.push_back(c);
  }

  int64_t N = n_ids.size();
  // int32_t N = n_ids.size();
  auto out_n_id = torch::from_blob(n_ids.data(), {N}, idx.options()).clone();

  free(neighbor_buffer);
  close(col_fd);
  return out_n_id;
}

void lz4_sample() {
    int num_elems = 7;
    int64_t* src_int = (int64_t*) malloc(num_elems * sizeof(int64_t));
    src_int[0] = 123123124;
    src_int[1] = 334234;
    src_int[2] = 454365346;
    src_int[3] = 23123123;
    src_int[4] = 3423423;
    src_int[5] = 123123123;
    src_int[6] = 5454552342;

    for (int i = 0; i < num_elems; i++)
      printf("src_int[%d] = %ld\n", i, src_int[i]);

    const int src_size = num_elems * sizeof(int64_t);
    const int max_dst_size = LZ4_compressBound(src_size);
    int64_t* compressed_data = (int64_t*) malloc((size_t)max_dst_size);
    const int compressed_data_size = LZ4_compress_default((const char*) src_int, (char*) compressed_data, src_size, max_dst_size);
    compressed_data = (int64_t *) realloc(compressed_data, (size_t)compressed_data_size);

    printf("We successfully compressed some data! Ratio: %.2f\n", (float) compressed_data_size/src_size);

    free(src_int);
    free(compressed_data);
}

void fill_neighbor_cache(torch::Tensor cache, torch::Tensor rowptr, std::string col, 
                torch::Tensor cached_idx, torch::Tensor cache_table, int64_t num_entries) {
                // torch::Tensor cached_idx, torch::Tensor cache_table, int32_t num_entries) {

    int64_t* cached_idx_data = cached_idx.data_ptr<int64_t>();
    // int32_t* cached_idx_data = cached_idx.data_ptr<int32_t>();
    int64_t* cache_table_data = cache_table.data_ptr<int64_t>();
    // int32_t* cache_table_data = cache_table.data_ptr<int32_t>();
    int64_t* cache_data = cache.data_ptr<int64_t>();
    // int32_t* cache_data = cache.data_ptr<int32_t>();

    #pragma omp parallel for num_threads(atoi(getenv("GINEX_NUM_THREADS")))
    for (int64_t n=0; n<num_entries; n++){
    // for (int32_t n=0; n<num_entries; n++){
        int64_t idx = cached_idx_data[n];
        // int32_t idx = cached_idx_data[n];
        auto neighbors = get_neighbors(rowptr, col, cached_idx[n]);  
        int64_t num_neighbors = neighbors.numel();
        // int32_t num_neighbors = neighbors.numel();

        int64_t position = cache_table_data[idx];
        // int32_t position = cache_table_data[idx];

        // cache update
        cache_data[position] = num_neighbors;
        memcpy(cache_data+position+1, (int64_t*)neighbors.data_ptr(), num_neighbors*sizeof(int64_t));
        // memcpy(cache_data+position+1, (int32_t*)neighbors.data_ptr(), num_neighbors*sizeof(int32_t));
    }   
    // lz4_sample();
    return;
}


void compress_neighbor_cache(torch::Tensor ginex_cache, torch::Tensor ginex_cache_table, int64_t num_nodes) {

    int64_t* ginex_cache_data = ginex_cache.data_ptr<int64_t>();
    int64_t* ginex_cache_table_data = ginex_cache_table.data_ptr<int64_t>();
    int64_t* my_cache_table_data = (int64_t*) malloc(num_nodes * 3 * sizeof(int64_t));

    FILE *my_cache_f;
    my_cache_f = fopen("nc_size_45000000000.dat.lz4", "wb");

    int64_t start_offset = 0;
    for (int64_t i = 0; i < num_nodes; i++) {
      int64_t ginex_cache_idx = ginex_cache_table_data[i];
      if (ginex_cache_idx == -1) {
        my_cache_table_data[i * 3] = -1;
        my_cache_table_data[i * 3 + 1] = 0; // don't care
        my_cache_table_data[i * 3 + 2] = 0; // don't care
      } else {
        int64_t num_neighbors = ginex_cache_data[ginex_cache_idx];
        int64_t* src_int64 = (int64_t*) malloc(num_neighbors * sizeof(int64_t));
        for (int64_t j = 1; j <= num_neighbors; j++) { // TODO: think of case when num_neighbors = 0
          src_int64[j - 1] = ginex_cache_data[ginex_cache_idx + j];
        }
        int src_size = num_neighbors * sizeof(int64_t);
        int max_dst_size = LZ4_compressBound(src_size);
        int64_t* compressed_data = (int64_t*) malloc((size_t) max_dst_size);
        int compressed_data_size = LZ4_compress_default((const char*) src_int64, (char*) compressed_data, src_size, max_dst_size);
        compressed_data = (int64_t *) realloc(compressed_data, (size_t) compressed_data_size);
        
        my_cache_table_data[i * 3] = start_offset;
        my_cache_table_data[i * 3 + 1] = (int64_t) compressed_data_size;
        my_cache_table_data[i * 3 + 2] = num_neighbors;
        start_offset += compressed_data_size;

        fwrite(compressed_data, 1, compressed_data_size, my_cache_f);

        free(src_int64);
        free(compressed_data);
      }
    }

    fclose(my_cache_f);

    FILE *my_cache_table_f;
    my_cache_table_f = fopen("nctbl_size_45000000000_lz4.dat", "wb");
    int64_t my_cache_table_size = num_nodes * 3 * sizeof(int64_t);
    fwrite(my_cache_table_data, 1, my_cache_table_size, my_cache_table_f);
    fclose(my_cache_table_f);

    free(my_cache_table_data);
}


PYBIND11_MODULE(sample, m) {
	m.def("sample_adj_ginex", &sample_adj_ginex, "ginex version of sample_adj");
  m.def("fill_neighbor_cache", &fill_neighbor_cache, "fetch neighbors of given indices into the cache and set the cache table");
  m.def("compress_neighbor_cache", &compress_neighbor_cache, "compress neighbor cache");
}

