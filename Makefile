# Makefile for STREAM with Caliper and Variorum integration

# Compiler Settings
CC = gcc -std=c99
CFLAGS = -O3 -Wall -fopenmp

# Caliper Settings
#CALIPER_PATH = /g/g15/jeter3/build-lassen/caliper
#CALIPER_LIBS = -L$(CALIPER_PATH)/lib64 -lcaliper

CALIPER_PATH = /g/g15/jeter3/build-lassen/caliper-no-variorum
CALIPER_LIBS = -L$(CALIPER_PATH)/lib64 -lcaliper

OPENMPI_PATH = /g/g15/jeter3/build-lassen/spack/opt/spack/linux-rhel7-power9le/gcc-8.3.1/openmpi
OPENMPI_LIBS = -L$(OPENMPI_PATH)/lib -lmpi

# Variorum Settings
#VARIORUM_PATH = /g/g15/jeter3/build-lassen/variorum
#VARIORUM_LIBS = -L$(VARIORUM_PATH)/lib -lvariorum

#VARIORUM_PATH = /g/g15/jeter3/variorum/
#VARIORUM_LIBS = -L$(VARIORUM_PATH)/build/variorum/ -lvariorum

CALIPER_INCLUDE = -I$(CALIPER_PATH)/include/caliper
OPENMPI_INCLUDE = -I$(OPENMPI_PATH)/include
#VARIORUM_INCLUDE = -I$(VARIORUM_PATH)/include

# Linking
#LDFLAGS = $(CALIPER_LIBS) $(VARIORUM_LIBS) $(OPENMPI_LIBS)
LDFLAGS = $(CALIPER_LIBS) $(OPENMPI_LIBS)

all: stream

# Targets
stream: stream.c
	$(CC) $(CFLAGS) $(CALIPER_INCLUDE) $(OPENMPI_INCLUDE) -o $@ $< $(LDFLAGS)
