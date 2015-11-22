CFLAGS=-Wall -DFUSE_USE_VERSION=29 `pkg-config fuse --cflags`
LFLAGS=-Wall `pkg-config fuse --libs`

all: bin/qosfs

clean:
	rm -rf bin obj

bin:
	mkdir -p bin

