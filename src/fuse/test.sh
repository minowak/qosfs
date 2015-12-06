#!/bin/bash

echo "Tests starting"
echo "Creating test directory"
mkdir testdir
echo "Creating mount point"
mkdir testmount

echo "Mounting FS"
sudo ./qosfs testdir testmount 1 1 -f -s &
fspid=$!
homepath=$PWD
sleep 5

function quit {
	rc=$1
	cd $homepath
	sudo umount testmount
	rm -rf testdir
	rm -rf testmount
	exit $rc
}

echo "Entering mount point"
cd testmount

echo "Testing creating empty file"
touch testfile
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing creating file with content"
echo 'testcontent' > testcontent
rc=$

echo "Testing reading from file"
cat testcontent
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing removing a file"
rm testfile
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing creating a directory"
mkdir dir2
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Test chmod"
chmod 600 testcontent
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing chown"
chown $USER testcontent
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing mv"
mv testcontent file2
rc=$?; if [[ $rc != 0 ]]; then quit $rc; fi

echo "Testing done"
quit $?

