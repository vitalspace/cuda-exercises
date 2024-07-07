#include <stdio.h>
#include <cuda_runtime.h>


// Pude que el resultado no sea lo que esperas, recuerda que en CUDA o en este bloque de codigo se esta trabajando en paralelo
// por lo que no veras los numeros y mensajes consecutivamente. 

__global__ void fizzBuzz(int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x + 1;

    if (idx <= n) {
        if (idx % 3 == 0 && idx % 5 == 0) {
            printf("FizzBuzz\n");
        } else if (idx % 3 == 0) {
            printf("Fizz\n");
        } else if (idx % 5 == 0) {
            printf("Buzz\n");
        } else {
            printf("%d\n", idx);
        }
    }
}

int main() {
    const int n = 100;

    int blockSize = 256;
    int numBlocks = (n + blockSize - 1) / blockSize;
    fizzBuzz<<<numBlocks, blockSize>>>(n);

    cudaDeviceSynchronize();

    return 0;
}
