# HOWTO Installation and usage

This method was tested on _Ubuntu 15.10_ with kernel version 4.2.0-16-generic

Required libraries:
* fuse
* cgroups

## FUSE installation
FUSE should be already installed on this distribution. I case it isn't it can be installed via command:

```
sudo apt-get install fuse libfuse-dev
```

## Cgroups installation
Cgroups can be installed via command:

```
sudo apt-get install cgroup-bin
```

## Getting the code
Git is required to obtain project source code.

```
sudo apt-get install git
```

Cloning repository

```
git clone https://github.com/minowak/qosfs
```

The most recent working version is located on development branch

```
git checkout develop
```

## Compiling
To compile project:

```
cd ./src/fuse
make
```

## Running
Project requires root access to mount filesystem.

```
sudo ./qosfs [dir] [mountpoint] [read Mb/s] [write Mb/s] -f -s
```

* _dir_ is a directory to be mounted
* _mountpoint_ is mount point
* disk speed limits are passed in Mb/s

## Testing
To test if filesystem is workig corretly

Writing speed:
```
dd if=/dev/zero of=[mountpoint]/tempfile bs=250k count=1024
```

Reading speed:
```
dd if=[mountpoint]/tempfile of=/dev/null bs=250k count=1024
```
