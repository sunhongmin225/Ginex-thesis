#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <cstring>
#include <inttypes.h>
#include <omp.h>
#include <stdio.h>
#define ALIGNMENT 4096

int main() {

    int64_t row_count = 2532;
    int64_t size_0 = (row_count*sizeof(int64_t) + 1*ALIGNMENT)&(long)~(ALIGNMENT-1);
    int64_t size_1 = (row_count*sizeof(int64_t) + 2*ALIGNMENT)&(long)~(ALIGNMENT-1);
    int64_t size_2 = (row_count*sizeof(int64_t) + 3*ALIGNMENT)&(long)~(ALIGNMENT-1);
    printf("1000 & (long)~(ALIGNMENT-1)= %ld\n", 1000 & (long)~(ALIGNMENT-1));
    printf("2000 & (long)~(ALIGNMENT-1)= %ld\n", 2000 & (long)~(ALIGNMENT-1));
    printf("3000 & (long)~(ALIGNMENT-1)= %ld\n", 3000 & (long)~(ALIGNMENT-1));
    printf("4000 & (long)~(ALIGNMENT-1)= %ld\n", 4000 & (long)~(ALIGNMENT-1));
    printf("5000 & (long)~(ALIGNMENT-1)= %ld\n", 5000 & (long)~(ALIGNMENT-1));
    printf("6000 & (long)~(ALIGNMENT-1)= %ld\n", 6000 & (long)~(ALIGNMENT-1));
    printf("7000 & (long)~(ALIGNMENT-1)= %ld\n", 7000 & (long)~(ALIGNMENT-1));
    printf("8000 & (long)~(ALIGNMENT-1)= %ld\n", 8000 & (long)~(ALIGNMENT-1));
    printf("9000 & (long)~(ALIGNMENT-1)= %ld\n", 9000 & (long)~(ALIGNMENT-1));

    printf("row_count*sizeof(int64_t) + 1*ALIGNMENT = %ld\n", row_count*sizeof(int64_t) + 1*ALIGNMENT);
    printf("(long)~(ALIGNMENT-1) = %ld\n", (long)~(ALIGNMENT-1));
    printf("sizeof(int64_t) = %ld, size_0 = %ld, size_1 = %ld, size_2 = %ld\n", sizeof(int64_t), size_0, size_1, size_2);
    printf("1<<10 = %d\n", 1<<10);

    int32_t neighbor_buffer_size = 1<<15; // 2**15
    // int64_t* neighbor_buffer = (int64_t*)malloc(neighbor_buffer_size*sizeof(int64_t) + 2*ALIGNMENT);
    int32_t* neighbor_buffer = (int32_t*)malloc(neighbor_buffer_size*sizeof(int32_t) + 2*ALIGNMENT);
    // int64_t* aligned_neighbor_buffer = (int64_t*)(((long)neighbor_buffer+(long)ALIGNMENT)&(long)~(ALIGNMENT-1));
    int32_t* aligned_neighbor_buffer = (int32_t*)(((long)neighbor_buffer+(long)ALIGNMENT)&(long)~(ALIGNMENT-1));

    printf("sizeof(neighbor_buffer) = %ld, sizeof(aligned_neighbor_buffer) = %ld\n", sizeof(neighbor_buffer), sizeof(aligned_neighbor_buffer));
    printf("neighbor_buffer = %p, aligned_neighbor_buffer = %p\n", neighbor_buffer, aligned_neighbor_buffer);
    printf("*neighbor_buffer = %d, *aligned_neighbor_buffer = %d\n", *neighbor_buffer, *aligned_neighbor_buffer);
    free(neighbor_buffer);
    // free(aligned_neighbor_buffer);
}
