#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern "C" {
    #include "lz4.h"
}
#include <vector>
#include <time.h>

int main (void) {

    size_t ret = 0;
    int64_t num_nodes = 220412610;
    struct timespec start_wall, end_wall;
    double wall_time_used = 0.0;

    printf("arcmsh::begin reading nctbl_size_45000000000_metadata.txt\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    FILE *metadata_f;
    metadata_f = fopen ("nctbl_size_45000000000_metadata.txt", "r");
    int my_cache_table_compressed_data_size = 0;
    int my_cache_table_size = 0;
    fscanf(metadata_f, "%d", &my_cache_table_compressed_data_size);
    while (!feof (metadata_f)) {
        fscanf (metadata_f, "%d", &my_cache_table_size);
    }
    fclose (metadata_f);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nctbl_size_45000000000_metadata.txt with my_cache_table_compressed_data_size = %d, my_cache_table_size = %d\n", wall_time_used, my_cache_table_compressed_data_size, my_cache_table_size);

    printf("arcmsh::begin reading nctbl_size_45000000000.dat.lz4\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    FILE *nctbl_f;
    int64_t* nctbl_compressed_buffer = (int64_t*) malloc(my_cache_table_compressed_data_size);
    nctbl_f = fopen("nctbl_size_45000000000.dat.lz4", "rb");
    ret = fread(nctbl_compressed_buffer, 1, my_cache_table_compressed_data_size, nctbl_f);
    fclose(nctbl_f);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nctbl_size_45000000000.dat.lz4 with ret = %ld\n", wall_time_used, ret);

    printf("arcmsh::begin decompressing nctbl_size_45000000000.dat.lz4\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    int64_t* nctbl_regen_buffer = (int64_t*) malloc(my_cache_table_size);
    int nctbl_decompressed_size = LZ4_decompress_safe((char*) nctbl_compressed_buffer, (char*) nctbl_regen_buffer, my_cache_table_compressed_data_size, my_cache_table_size);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully decompressed nctbl_size_45000000000.dat.lz4 with nctbl_decompressed_size in bytes = %d\n", wall_time_used, nctbl_decompressed_size);

    // for (int i = 0; i < 100; i++) {
    //     printf("nctbl_regen_buffer[%d] = %ld\n", i, nctbl_regen_buffer[i]);
    // }

    printf("arcmsh::begin reading nc_size_45000000000.dat.lz4\n");
    clock_gettime(CLOCK_REALTIME, &start_wall);
    int64_t my_cache_compressed_data_size = 0;
    for (int i = 0; i < num_nodes; i++) {
        my_cache_compressed_data_size += nctbl_regen_buffer[3 * i + 1];
    }
    printf("arcmsh::my_cache_compressed_data_size = %ld\n", my_cache_compressed_data_size);
    FILE *nc_f;
    int64_t* nc_compressed_buffer = (int64_t*) malloc(my_cache_compressed_data_size);
    nc_f = fopen("nc_size_45000000000.dat.lz4", "rb");
    ret = fread(nc_compressed_buffer, 1, my_cache_compressed_data_size, nc_f);
    fclose(nc_f);
    clock_gettime(CLOCK_REALTIME, &end_wall);
    wall_time_used = (end_wall.tv_sec - start_wall.tv_sec) + (end_wall.tv_nsec - start_wall.tv_nsec) * (1e-9);
    printf("arcmsh::[%f secs] successfully read nc_size_45000000000.dat.lz4 with ret = %ld\n", wall_time_used, ret);

    free(nctbl_compressed_buffer);
    free(nctbl_regen_buffer);
    free(nc_compressed_buffer);

    return 0;
}
