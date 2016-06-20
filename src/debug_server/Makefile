ELF = bin/main.elf

COMMON_PATH = ../common


COMMON+= $(COMMON_PATH)/log.o
COMMON+= $(COMMON_PATH)/math.o

COMMON+= $(COMMON_PATH)/debug_log.o
COMMON+= $(COMMON_PATH)/error_log.o
COMMON+= $(COMMON_PATH)/getch.o
COMMON+= $(COMMON_PATH)/time.o

COMMON+= $(COMMON_PATH)/cfg.o


COMMON+= $(COMMON_PATH)/agent_interface/agent_interface.o
COMMON+= $(COMMON_PATH)/agent_interface/agent_group.o

COMMON+= $(COMMON_PATH)/server/server.o
COMMON+= $(COMMON_PATH)/client/client.o

COMMON+= $(COMMON_PATH)/map/map.o
COMMON+= $(COMMON_PATH)/environment/environment.o

COMMON+= $(COMMON_PATH)/visualisation/robot_visualisation.o
COMMON+= $(COMMON_PATH)/bot_to_color.o












CC = g++
LD = g++
OBJCOPY = objcopy
OBJDUMP = objdump
SIZE = size

CFLAGS = -O2 -Os -s -Wall -Wextra -pedantic -std=c++0x
LDFLAGS = -lm -lpthread -pthread -std=c++0x  -lglut -lGL -lGLU

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
