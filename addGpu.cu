// #include "../common/book.h"
#include <stdio.h>
#define N 10

#define HANDLE_ERROR( err ) ( HandleError( err, __FILE__, __LINE__ ) )
static void HandleError(cudaError_t err, const char *file, int line)
{if (err != cudaSuccess)
{printf("%s in %s at line %d\n", cudaGetErrorString(err),file, line);
exit(EXIT_FAILURE);
}
}

__global__ void add( int *a, int *b, int *c ) {
 int tid = blockIdx.x; // handle the data at this index
 if (tid < N)
 c[tid] = a[tid] + b[tid];
}

int main( void ) {
 int a[N], b[N], c[N];
 int *dev_a, *dev_b, *dev_c;
 // allocate the memory on the GPU
  cudaMalloc( (void**)&dev_a, N * sizeof(int) ) ;
  cudaMalloc( (void**)&dev_b, N * sizeof(int) ) ;
  cudaMalloc( (void**)&dev_c, N * sizeof(int) ) ;
 // fill the arrays 'a' and 'b' on the CPU
 for (int i=0; i<N; i++) {
 a[i] = -i;
 b[i] = i * i;
 }

 // copy the arrays 'a' and 'b' to the GPU
  cudaMemcpy( dev_a, a, N * sizeof(int),
 cudaMemcpyHostToDevice ) ;
  cudaMemcpy( dev_b, b, N * sizeof(int),
 cudaMemcpyHostToDevice ) ;
 add<<<N,1>>>( dev_a, dev_b, dev_c );
 // copy the array 'c' back from the GPU to the CPU
  cudaMemcpy( c, dev_c, N * sizeof(int),
 cudaMemcpyDeviceToHost ) ;
 // display the results
 for (int i=0; i<N; i++) {
 printf( "%d + %d = %d\n", a[i], b[i], c[i] );
 }
 // free the memory allocated on the GPU
 cudaFree( dev_a );
 cudaFree( dev_b );
 cudaFree( dev_c );
 return 0;
}
