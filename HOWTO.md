# HOWTO Installation and usage

Project was tested on _Ubuntu 15.10_ with kernel version 4.2.0-16-generic and
 _CentOS 7_ with kernel version 3.10.0-229.e17.x86_64.

Required libraries:
* fuse
* cgroups

CentOS minimal also requires installation of _gcc_

```
yum install gcc
```

## FUSE installation

### Ubuntu
```
sudo apt-get install fuse libfuse-dev
```

### CentOS
```
yum install fuse-libs fuse-devel
```

## Cgroups installation

### Ubuntu
```
sudo apt-get install cgroup-bin
```

### CentOS
```
yum install libcgroup libcgroup-tools
```

## Getting the code
Git is required to obtain project source code.

### Ubuntu
```
sudo apt-get install git
```

### CentOS
```
yum install git
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
