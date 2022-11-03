#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern "C" {
    #include "lz4.h"
}
#include <vector>
#include <time.h>
#include <aio.h>
#include <omp.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <cstring>
#include <string>
#include <inttypes.h>
#define ALIGNMENT 4096
#define GINEX_NUM_THREADS 128

int64_t* load_int64 (std::string file, int64_t size) {

    int fd = open(file.c_str(), O_RDONLY | O_DIRECT);

    int64_t result_buffer_size = size * sizeof(int64_t) + ALIGNMENT;
    int64_t num_blocks = result_buffer_size / ALIGNMENT;
    int64_t* result_buffer = (int64_t*) aligned_alloc(ALIGNMENT, result_buffer_size);

    #pragma omp parallel for num_threads(GINEX_NUM_THREADS)
    for (int64_t n = 0; n < num_blocks; n++) {
        int64_t offset = n * ALIGNMENT;
        if (pread(fd, result_buffer + (ALIGNMENT / sizeof(int64_t)) * n, ALIGNMENT, offset) == -1) {
            fprintf(stderr, "load.cpp::2::ERROR: %s\n", strerror(errno));
        }
    }

    close(fd);

    return result_buffer;
}

int8_t* load_int8 (std::string file, int64_t size) {

    int fd = open(file.c_str(), O_RDONLY | O_DIRECT);

    int64_t result_buffer_size = size * sizeof(int8_t) + ALIGNMENT;
    int64_t num_blocks = result_buffer_size / ALIGNMENT;
    int8_t* result_buffer = (int8_t*) aligned_alloc(ALIGNMENT, result_buffer_size);

    #pragma omp parallel for num_threads(GINEX_NUM_THREADS)
    for (int64_t n = 0; n < num_blocks; n++) {
        int64_t offset = n * ALIGNMENT;
        if (pread(fd, result_buffer + (ALIGNMENT / sizeof(int8_t)) * n, ALIGNMENT, offset) == -1) {
            fprintf(stderr, "load.cpp::2::ERROR: %s\n", strerror(errno));
        }
    }

    close(fd);

    return result_buffer;
}

int main (void) {

    int64_t num_nodes = 220412610;
    struct timespec start_wall, end_wall;
    double wall_time_used = 0.0;
    int64_t my_cache_table_data_size = num_nodes * 3 * sizeof(int64_t);

    // Load nctbl
    printf("arcmsh::begin reading nctbl_size_45000000000_lz4.dat.\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    std::string nctbl_f = "nctbl_size_45000000000_lz4.dat";
    int64_t* nctbl_buffer = load_int64(nctbl_f, my_cache_table_data_size / sizeof(int64_t));
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nctbl_size_45000000000_lz4.dat.\n", wall_time_used);

    // Load nc_orig
    // It takes 1529.773292 vs 20.975385 seconds to read nc_size_64000000000_orig.dat using fread() vs load_int64()
    printf("arcmsh::begin reading nc_size_64000000000_orig.dat.\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    std::string nc_orig_f = "nc_size_64000000000_orig.dat";
    int64_t* nc_orig_buffer = load_int64(nc_orig_f, 7779587390);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nc_size_64000000000_orig.dat.\n", wall_time_used);

    // Load nctbl_orig
    printf("arcmsh::begin reading nctbl_size_64000000000_orig.dat.\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    std::string nctbl_orig_f = "nctbl_size_64000000000_orig.dat";
    int64_t* nctbl_orig_buffer = load_int64(nctbl_orig_f, num_nodes);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nctbl_size_64000000000_orig.dat.\n", wall_time_used);

    for (int i = 0; i < 30; i++) {
        printf("nctbl_buffer[%d] = %ld\n", i, nctbl_buffer[i]);
    }

    for (int i = 0; i < 10; i++) {
        printf("nctbl_orig_buffer[%d] = %ld\n", i, nctbl_orig_buffer[i]);
    }

    // Load compressed nc
    printf("arcmsh::begin reading nc_size_45000000000.dat.lz4\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    int64_t my_cache_compressed_data_size = 0;
    for (int i = 0; i < num_nodes; i++) {
        my_cache_compressed_data_size += nctbl_buffer[3 * i + 1];
    }
    printf("arcmsh::my_cache_compressed_data_size = %ld\n", my_cache_compressed_data_size);
    std::string nc_f = "nc_size_45000000000.dat.lz4";
    int8_t* nc_buffer = load_int8(nc_f, my_cache_compressed_data_size / sizeof(int8_t));
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nc_size_45000000000.dat.lz4.\n", wall_time_used);

    // Decompress compressed nc
    printf("arcmsh::begin decompressing nc_size_45000000000.dat.lz4\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    int64_t start_offset = 0;
    for (int64_t i = 0; i < num_nodes; i++) {
        int src_size = nctbl_buffer[3 * i + 2] * sizeof(int64_t);
        int compressed_data_size = nctbl_buffer[3 * i + 1];
        int64_t* regen_buffer = (int64_t*) malloc(src_size);

        int decompressed_size = LZ4_decompress_safe((char*) (nc_buffer) + start_offset, (char*) regen_buffer, compressed_data_size, src_size);
        start_offset += compressed_data_size;
        if (memcmp(&nc_orig_buffer[nctbl_orig_buffer[i] + 1], regen_buffer, src_size) != 0)
            printf("Validation failed.  *src and *new_src are not identical.\n");
        else
            printf("Validation done for i = %ld.\n", i);
        if (i == 0) {
            for (int j = 0; j < nctbl_buffer[3 * i + 2]; j++) {
                printf("regen_buffer[%d] = %ld\n", j, regen_buffer[j]);
            }
        }
        free(regen_buffer);
        // if (i == 30 - 1) { break; }
    }

    for (int i = 1; i <= nc_orig_buffer[nctbl_orig_buffer[0]]; i++) {
        printf("nc_orig_buffer[nctbl_orig_buffer[0] + %d] = %ld\n", i, nc_orig_buffer[nctbl_orig_buffer[0] + i]);
    }

    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully decompressed nc_size_45000000000.dat.lz4.\n", wall_time_used);

    free(nctbl_buffer);
    free(nc_buffer);
    free(nc_orig_buffer);
    free(nctbl_orig_buffer);

    return 0;
}
