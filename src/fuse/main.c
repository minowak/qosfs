/*
 * QosFS: Filesystem with Quality of Service support
 *
 * gcc -Wall main.c `pkg-config fuse --cflags --libs` -o qosfs
 */

#include "include/params.h"

#include <fuse.h>
#include <limits.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <syslog.h>
#include <unistd.h>
#include <dirent.h>

#define LOG_CALL(F) (syslog(LOG_INFO, "%s() for %s", F, path))
#define LOG_ERROR(F) (syslog(LOG_ERR, "error in %s() for %s", F, path))

char * root_dir;

static void fullpath(char fpath[PATH_MAX], const char * path)
{
	strcpy(fpath, root_dir);
	strncat(fpath, path, PATH_MAX);
}

/**
 * Get attributes
 */
int qosfs_getattr(const char * path, struct stat * statbuf)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("getattr");

	fullpath(fpath, path);
	if((result = lstat(fpath, statbuf)) != 0)
	{
		LOG_ERROR("getattr");
	}

	return result;
}

/**
 * Read target of a symbolic link
 */
int qosfs_readlink(const char * path, char * link, size_t size)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("readlink");
	fullpath(fpath, path);

	if((result = readlink(fpath, link, size - 1)) < 0)
	{
		LOG_ERROR("readlink");
	}

	link[result] = '\0';
	result = 0;

	return result;
}

/**
 * Create a file node
 */
int qosfs_mknod(const char * path, mode_t mode, dev_t dev)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("mknod");

	fullpath(fpath, path);

	if(S_ISREG(mode)) 
	{
		if((result = open(fpath, O_CREAT | O_EXCL | O_WRONLY, mode)) < 0)
		{
			LOG_ERROR("mknod");
		} else 
		{
			if((result = close(result)) < 0)
			{
				LOG_ERROR("mknod");
			}
		}
	} else
	{
		if(S_ISFIFO(mode))
		{
			if((result = mkfifo(fpath, mode)) < 0)
			{
				LOG_ERROR("mknod");
			} else
		} else
		{
			if((result = mknod(fpath, mode, dev)) < 0)
			{
				LOG_ERROR("mknod");
			}
		}
	}

	return result;
}

/**
 * Open directory
 */
int qosfs_opendir(const char * path, struct fuse_file_info * ffi)
{
	int result = 0;
	char fpath[PATH_MAX];
	DIR * dp;

	LOG_CALL("opendir");

	fullpath(fpath, path);

	if((dp = opendir(fpath)) == NULL)
	{
		LOG_ERROR("opendir");
	}

	ffi->fh = (intptr_t) dp;

	return result;
}

/**
 * Read the directory
 */
int qosfs_readdir(const char * path, void * buf, fuse_fill_dir_t filler, off_t offset, 
		struct fuse_file_info * ffi)
{
	int result = 0;
	DIR * dp;
	struct dirent * de;

	LOG_CALL("readdir");

	dp = (DIR *) (uintptr_t) ffi->fh;
	de = readdir(dp);
	if((de = readdir(dp)) == NULL)
	{
		LOG_ERROR("readdir");
		return result;
	}

	do
	{
		syslog(LOG_INFO, "calling filler %s", de->d_name);
		if(filler(buf, de->d_name, NULL, 0) != 0)
		{
			return -ENOMEM;
		}
	} while((de = readdir(dp)) != NULL);

	return result;
}

/**
 * Open file.
 */
int qosfs_open(const char * path, struct fuse_file_info * ffi)
{
	int result = 0;
	int fd;
	char fpath[PATH_MAX];

	LOG_CALL("open");

	fullpath(fpath, path);
	if((fd = open(fpath, ffi->flags) < 0))
	{
		LOG_ERROR("open");
	}

	ffi->fh = fd;

	return result;
}

/**
 * Read from opened file.
 */
int qosfs_read(const char * path, char * buf, size_t size, off_t offset, struct fuse_file_info * ffi)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("read");

	if((result = pread(ffi->fh, buf, size, offset)) < 0)
	{
		LOG_ERROR("read");
	}

	return result;
}

/**
 * Write to opened file.
 */
int qosfs_write(const char * path, const char * buf, size_t size, off_t offset,
		struct fuse_file_info * ffi)
{
	int result = 0;

	LOG_CALL("write");

	if((result = pwrite(ffi->fh, buf, size, offset)) < 0)
	{
		LOG_ERROR("write");
	}

	return result;
}

/**
 * Release an open file.
 */
int qosfs_release(const char * path, struct fuse_file_info * ffi)
{
	int result = 0;

	LOG_CALL("release");

	if((result = close(ffi->fh)) < 0)
	{
		LOG_ERROR("release");
	}

	return result;
}

/**
 * Initialize filesystem.
 */
void * qosfs_init(struct fuse_conn_info * conn)
{
	syslog(LOG_INFO, "init() called");

	return NULL;
}

/**
 * Destroy filesystem.
 */
void qosfs_destroy(void * userdata)
{
}

struct fuse_operations qosfs_operations =
{
	.readlink = qosfs_readlink,
	.getattr = qosfs_getattr,
	.mknod = qosfs_mknod,
	.readdir = qosfs_readdir,
	.opendir = qosfs_opendir,
	.open = qosfs_open,
	.release = qosfs_release,
	.read = qosfs_read,
	.write = qosfs_write,
	.init = qosfs_init,
	.destroy = qosfs_destroy,
};

int main(int argc, char ** argv)
{
	int i, fuse_stat;

	openlog(LOG_TAG, LOG_PID|LOG_CONS, LOG_USER);
	syslog(LOG_INFO, "Mounting filesystem.");

	for (i = 1 ; i < argc && (argv[i][0] == '-') ; i++)
	{
		if  (i == argc)
		{
			return (-1);
		}
	}

	root_dir = realpath(argv[i], NULL);
	syslog(LOG_INFO, "Setting root dir: %s", root_dir);

	for(; i < argc ; i++)
	{
		argv[i] = argv[i+1];
	}

	argc--;

	fuse_stat = fuse_main(argc, argv, &qosfs_operations, NULL);

	syslog(LOG_INFO, "fuse_main returned %d", fuse_stat);

	closelog();

	return fuse_stat;
}

