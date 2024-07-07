#include <stdio.h>
#include <cuda_runtime.h>

__global__ void multiply(int *a, int *b, int *c)
{
    *c = *a * *b;
}

int main()
{
    int h_a = 5;
    int h_b = 5;
    int h_c;

    int *d_a, *d_b, *d_c;

    cudaMalloc((void **)&d_a, sizeof(int));
    cudaMalloc((void **)&d_b, sizeof(int));
    cudaMalloc((void **)&d_c, sizeof(int));

    cudaMemcpy(d_a, &h_a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &h_b, sizeof(int), cudaMemcpyHostToDevice);

    multiply<<<1, 1>>>(d_a, d_b, d_c);

    cudaMemcpy(&h_c, d_c, sizeof(int), cudaMemcpyDeviceToHost);

    printf("%d * %d = %d\n", h_a, h_b, h_c);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}