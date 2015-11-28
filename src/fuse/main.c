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

char * root_dir;

static void fullpath(char fpath[PATH_MAX], const char * path)
{
	strcpy(fpath, root_dir);
	strncat(fpath, path, PATH_MAX);
}

/**
 * Read the target of a symbolic link.
 */
int qosfs_readlink(const char * path, char * link, size_t size)
{
	return 0;
}

/**
 * Open file.
 */
int qosfs_open(const char * path, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Read from opened file.
 */
int qosfs_read(const char * path, char * buf, size_t size, off_t offset, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Write to opened file.
 */
int qosfs_write(const char * path, const char * buf, size_t size, off_t offset,
		struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Get filesystem statistics.
 */
int qosfs_statfs(const char * path, struct statvfs * statv)
{
	return 0;
}

/**
 * Release an open file.
 */
int qosfs_release(const char * path, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Initialize filesystem.
 */
void * qosfs_init(struct fuse_conn_info * conn)
{
	return NULL:
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
	.open = qosfs_open,
	.release = qosfs_release,
	.read = qosfs_read,
	.write = qosfs_write,
	.statfs = qosfs_statfs,
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

