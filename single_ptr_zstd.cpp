#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <zstd.h>
// #include "common.h"


int main (int argc, const char** argv) {

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
      printf("zstd src_int[%d] = %ld\n", i, src_int[i]);

    const int src_size = num_elems * sizeof(int64_t);
    const int max_dst_size = ZSTD_compressBound(src_size);
    int64_t* compressed_data = (int64_t*) malloc((size_t)max_dst_size);
    const int compressed_data_size = ZSTD_compress(compressed_data, max_dst_size, src_int, src_size, 1);
    compressed_data = (int64_t *) realloc(compressed_data, (size_t)compressed_data_size);

    printf("We successfully compressed some data! Ratio: %.2f\n", (float) compressed_data_size/src_size);

    free(src_int);
    free(compressed_data);

    return 0;
}
