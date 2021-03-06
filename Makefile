NVCCFLAGS = -ccbin g++ -m64 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_60,code=sm_60 -gencode arch=compute_60,code=compute_60

INCLUDES = -I/usr/local/cuda-8.0/samples/common/inc/


all: testGpu


testGpu: testGpu.o
        nvcc $(NVCCFLAGS) $(INCLUDES) testGpu.cu -o testGpu

testGpu.o: testGpu.cu
        nvcc $(NVCCFLAGS) $(INCLUDES) testGpu.cu -o testGpu
