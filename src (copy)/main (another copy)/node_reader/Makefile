ELF = bin/main.elf

COMMON_PATH = ../common
PACKET_PATH = ../packet

COMMON+= $(COMMON_PATH)/getch.o
COMMON+= $(COMMON_PATH)/log.o
COMMON+= $(COMMON_PATH)/time.o

COMMON+= $(COMMON_PATH)/debug_log.o
COMMON+= $(COMMON_PATH)/error_log.o

COMMON+= $(COMMON_PATH)/cfg.o

COMMON+= $(COMMON_PATH)/server.o
COMMON+= $(COMMON_PATH)/client.o

COMMON+= $(PACKET_PATH)/packet.o





CC = g++
LD = g++
OBJCOPY = objcopy
OBJDUMP = objdump
SIZE = size

CFLAGS = -O2 -Os -s -Wall -Wextra -pedantic -std=c++0x
LDFLAGS = -lm -lpthread -pthread -std=c++0x

SRCS = $(shell find -name '*.cpp')

OBJS = $(SRCS:.cpp=.o)

OBJS+= $(COMMON)

all: $(ELF)
	$(SIZE) $(ELF)

$(ELF): $(OBJS)
	$(LD) -o $@ $(OBJS) $(LDFLAGS)

%.o: %.cpp
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm $(OBJS) -rf
