# Makefile for STREAM with Caliper and Variorum integration
CC = mpicc
CFLAGS = -O2 -fopenmp

FC = gfortran
FFLAGS = -O2 -fopenmp

#CALIPER_PATH = /g/g15/jeter3/build-lassen/caliper-no-variorum
CALIPER_PATH = /g/g15/jeter3/build-lassen/caliper
CALIPER_LIBS = -L$(CALIPER_PATH)/lib64 -lcaliper
CALIPER_INCLUDE = -I$(CALIPER_PATH)/include/caliper
LDFLAGS = $(CALIPER_LIBS)

all: stream_f.exe stream_c.exe

stream_f.exe: stream.f mysecond.o
	$(CC) $(CFLAGS) -c mysecond.c
	$(FC) $(FFLAGS) -c stream.f
	$(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

stream_c.exe: stream.c
	$(CC) $(CFLAGS) $(CALIPER_INCLUDE) -o $@ $< $(LDFLAGS)

clean:
	rm -f stream_f.exe stream_c.exe *.o

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
	icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc
