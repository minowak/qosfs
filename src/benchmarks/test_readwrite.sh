#!/bin/bash

TEST_DIR=./testdir
TEST_MNT=./testmnt

OUT_DIR=./out

READ_LIMIT=$1
WRITE_LIMIT=$2

# Create test directories
mkdir $TEST_DIR
mkdir $TEST_MNT
mkdir $OUT_DIR

# Mount FS
../fuse/qosfs $TEST_DIR $TEST_MNT $READ_LIMIT $WRITE_LIMIT

# Run fio
fio readwrite-1g.fio --output=$OUT_DIR/readwrite 

# Clean
umount $TEST_MNT
rm -rf $TEST_DIR
rm -rf $TEST_MNT

