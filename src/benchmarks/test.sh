#!/bin/bash

TEST_DIR=./testdir
TEST_MNT=./testmnt

OUT_DIR=./out

READ_LIMIT=$1
WRITE_LIMIT=$2

# Create test directories
echo "Creating directories..."
if [ ! -d "$TEST_DIR" ]
then
	mkdir $TEST_DIR
fi
if [ ! -d "$TEST_MNT" ]
then
	mkdir $TEST_MNT
fi
if [ ! -d "$OUT_DIR" ]
then
	mkdir $OUT_DIR
fi

# Mount FS
echo "Mounting QoSFS on $TEST_MNT"
../fuse/qosfs $TEST_DIR $TEST_MNT $READ_LIMIT $WRITE_LIMIT
sleep 20

# Run fio
echo "Running FIO"
fio config.fio --output=${OUT_DIR}1/results-all

# Change extensions
for LOGFILE in *.log ; 
	do mv $LOGFILE `echo $OUT_DIR/$LOGFILE | sed 's/\(.*\.\)[0-9].log/\1log/'` ;
done

# Plot
cd $OUT_DIR
fio_generate_plots "Sequential Test"
cd ..

# Clean
umount $TEST_MNT
rm -rf $TEST_DIR
rm -rf $TEST_MNT

