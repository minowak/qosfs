CFLAGS=-Wall -DFUSE_USE_VERSION=29 -DDEBUG `pkg-config fuse --cflags`
LFLAGS=-Wall `pkg-config fuse --libs` -lpthread
CC=gcc
SRC=main.c cgroups.c acontroller.c
OBJ=$(SRC:.c=.o)
BIN=qosfs

all: $(SRC) $(BIN)

clean:
	rm -rf *.o

$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LFLAGS)

.c.o:
	$(CC) -o $@ -c $< $(CFLAGS)

test:
	./test.sh
