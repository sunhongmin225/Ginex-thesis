#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <zstd.h>
#include <vector>

void run_screaming(const char* message, const int code) {
  printf("%s \n", message);
  exit(code);
}

int main(void) {

  // Data generation
  int num_elems_0 = 5;
  int64_t* src_int64_0 = (int64_t*) malloc(num_elems_0 * sizeof(int64_t));
  src_int64_0[0] = 912309;
  src_int64_0[1] = -334234;
  src_int64_0[2] = 192933;
  src_int64_0[3] = 231233;
  src_int64_0[4] = -543423;

  int num_elems_1 = 4;
  int64_t* src_int64_1 = (int64_t*) malloc(num_elems_1 * sizeof(int64_t));
  src_int64_1[0] = 6;
  src_int64_1[1] = 2;
  src_int64_1[2] = 7;
  src_int64_1[3] = -1;

  int num_elems_2 = 6;
  int64_t* src_int64_2 = (int64_t*) malloc(num_elems_2 * sizeof(int64_t));
  src_int64_2[0] = -612;
  src_int64_2[1] = 734;
  src_int64_2[2] = 713;
  src_int64_2[3] = 833;
  src_int64_2[4] = -423;
  src_int64_2[5] = 163;

  std::vector<int> num_elems;
  num_elems.push_back(num_elems_0);
  num_elems.push_back(num_elems_1);
  num_elems.push_back(num_elems_2);

  std::vector<int64_t*> src_int64;
  src_int64.push_back(src_int64_0);
  src_int64.push_back(src_int64_1);
  src_int64.push_back(src_int64_2);

  for (int i = 0; i < num_elems.size(); i++) {
    for (int j = 0; j < num_elems[i]; j++) {
      printf("src_int64_%d[%d] = %ld\n", i, j, src_int64[i][j]);
    }
    printf("\n");
  }

  size_t ret;
  std::vector<int64_t*> compressed_datas;
  std::vector<int> src_sizes;
  std::vector<int> compressed_data_sizes;

  
  // Compression
  for (int i = 0; i < num_elems.size(); i++) {
    int src_size = num_elems[i] * sizeof(int64_t);
    printf("src_size[%d] in bytes = %d\n", i, src_size);
    int max_dst_size = ZSTD_compressBound(src_size);
    printf("max_dst_size[%d] in bytes = %d\n", i, max_dst_size);
    int64_t* compressed_data = (int64_t*) malloc((size_t) max_dst_size);
    if (compressed_data == NULL)
      run_screaming("Failed to allocate memory for *compressed_data.", 1);

    int compressed_data_size = ZSTD_compress(compressed_data, max_dst_size, src_int64[i], src_size, 1);
    printf("compressed_data_size[%d] in bytes = %d\n", i, compressed_data_size);
    if (compressed_data_size <= 0)
      run_screaming("A 0 or negative result from LZ4_compress_default() indicates a failure trying to compress the data. ", 1);
    if (compressed_data_size > 0)
      printf("We successfully compressed some data for i = %d. Ratio: %.2f\n\n", i, (float) compressed_data_size/src_size);

    compressed_data = (int64_t *) realloc(compressed_data, (size_t) compressed_data_size);
    if (compressed_data == NULL)
      run_screaming("Failed to re-alloc memory for compressed_data.  Sad :(", 1);

    compressed_datas.push_back(compressed_data);
    compressed_data_sizes.push_back(compressed_data_size);
  }

  // Save as file
  FILE *fw;
  fw = fopen("toy_lz4.dat.lz4", "wb"); // "a"
  for (int i = 0; i < num_elems.size(); i++) {
    ret = fwrite(compressed_datas[i], 1, compressed_data_sizes[i], fw);
  }
  fclose(fw);
  printf("arcmsh::successfully wrote file will ret = %ld\n", ret);


  // // Read from file
  // FILE *fr;
  // compressed_data_sizes.push_back(35);
  // compressed_data_sizes.push_back(23);
  // compressed_data_sizes.push_back(37);
  // src_sizes.push_back(num_elems_0 * sizeof(int64_t));
  // src_sizes.push_back(num_elems_1 * sizeof(int64_t));
  // src_sizes.push_back(num_elems_2 * sizeof(int64_t));
  // int entire_compressed_buffer_size = 0;
  // for (int i = 0; i < num_elems.size(); i++) {
  //   entire_compressed_buffer_size += compressed_data_sizes[i];
  // }
  // int64_t* entire_compressed_buffer = (int64_t*) malloc(entire_compressed_buffer_size);
  // fr = fopen("toy_lz4.dat.lz4", "rb"); // "a"
  // ret = fread(entire_compressed_buffer, 1, entire_compressed_buffer_size, fr);
  // fclose(fr);
  // printf("arcmsh::successfully read file will ret = %ld\n", ret);

  // // Decompression
  // int64_t offset = 0;
  // for (int i = 0; i < num_elems.size(); i++) {
  //   int64_t* regen_buffer = (int64_t*) malloc(src_sizes[i]);
  //   int decompressed_size = LZ4_decompress_safe((char*) (entire_compressed_buffer) + offset, (char*) regen_buffer, compressed_data_sizes[i], src_sizes[i]);
  //   printf("decompressed_size in bytes = %d\n", decompressed_size);
  //   offset += compressed_data_sizes[i];
  //   for (int j = 0; j < num_elems[i]; j++) {
  //     printf("src_int64[%d][%d] = %ld\n", i, j, src_int64[i][j]);
  //     printf("regen_buffer[%d]  = %ld\n", j, regen_buffer[j]);
  //   }
  //   if (memcmp(src_int64[i], regen_buffer, src_sizes[i]) != 0)
  //     run_screaming("Validation failed.  *src and *new_src are not identical.", 1);
  //   printf("Validation done for i = %d.\n", i);
  //   free(regen_buffer);
  // }

  // int64_t* const regen_buffer = (int64_t*) malloc(src_size);
  // if (regen_buffer == NULL)
  //   run_screaming("Failed to allocate memory for *regen_buffer.", 1);
  
  // const int decompressed_size = LZ4_decompress_safe((char*) comp_buffer, (char*) regen_buffer, compressed_data_size, src_size);
  // printf("decompressed_size in bytes = %d\n", decompressed_size);
  // free(compressed_data);
  // free(comp_buffer);
  // if (decompressed_size < 0)
    // run_screaming("A negative result from LZ4_decompress_safe indicates a failure trying to decompress the data.  See exit code (echo $?) for value returned.", decompressed_size);
  // if (decompressed_size >= 0)
    // printf("We successfully decompressed some data!\n");
  // if (decompressed_size != src_size)
    // run_screaming("Decompressed data is different from original! \n", 1);

  // // Validation
  // for (int i = 0; i < num_elems; i++) {
  //   printf("   src_int64[%d] = %ld\n", i, src_int64[i]);
  //   printf("regen_buffer[%d] = %ld\n", i, regen_buffer[i]);
  // }
  // if (memcmp(src_int64, regen_buffer, src_size) != 0)
  //   run_screaming("Validation failed.  *src and *new_src are not identical.", 1);
  // printf("Validation done.\n");

  // Free
  for (int i = 0; i < num_elems.size(); i++) {
    free(src_int64[i]);
    // free(compressed_datas[i]);
  }
  // free(entire_compressed_buffer);

  return 0;
}
