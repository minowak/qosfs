/*
 * QosFS: Filesystem with Quality of Service support
 *
 * gcc -Wall main.c `pkg-config fuse --cflags --libs` -o qosfs
 */

#include "include/params.h"

#include <fuse.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <syslog.h>

/**
 * Get file attributes.
 * @param path path to the file
 * @param sbuf file statistics (like in stat())
 * @return errno
 */ 
static int qosfs_getattr(const char * path, struct stat * sbuf)
{
	int result = 0;
	char fpath[PATH_MAX];

	return result;
}

/**
 * Read the target of a symbolic link.
 */
int qosfs_readlink(const char * path, char * link, size_t size)
{
	return 0;
}

/**
 * Create a file node (all non-directory, non-symlink nodes).
 */
int qosfs_mknod(const char * path, mode_t mode, dev_t dev)
{
	return 0;
}

/**
 * Create a directory.
 */
int qosfs_mkdir(const char * path, mode_t mode)
{
	return 0;
}

/**
 * Remove a file.
 */
int qosfs_unlink(const char * path)
{
	return 0;
}

/**
 * Remove directory.
 */
int qosfs_rmdir(const char * path)
{
	return 0;
}

/**
 * Creates a symbolic link.
 */
int qosfs_symlink(const char * path, const char * new_path)
{
	return 0;
}

/**
 * Rename a file.
 */
int qosfs_rename(const char * path, const char * new_path)
{
	return 0;
}

/**
 * Create a hard link.
 */
int qosfs_link(const char * path, const char * new_path)
{
	return 0;
}

/**
 * Change mode of a file.
 */
int qosfs_chmod(const char * path, mode_t mode)
{
	return 0;
}

/**
 * Change file owner.
 */
int qosfs_chown(const char * path, uid_t uid, gid_t gid)
{
	return 0;
}

/**
 * Change size of a file.
 */
int qosfs_truncate(const char * path, off_t new_size)
{
	return 0;
}

/**
 * Change access/modification times of a file.
 */
int qosfs_utime(const char * path, struct utimbuf * ubuf)
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
 * Flush cached data.
 */
int qosfs_flush(const char * path, struct fuse_file_info * ffi)
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
 * Synchronize file contents.
 */
int qosfs_fsync(const char * path, int datasync, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Open directory.
 */
int qosfs_opendir(const char * path, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Read directory.
 */
int qosfs_readdir(const char * path, void * buf, fuse_fill_dir_t filler, off_t offset,
		struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Release directory.
 */
int qosfs_releasedir(const char * path, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Synchronize directory contents.
 */
int qosfs_fsyncdir(const char * path, int datasync, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Check file access permissions.
 */
int qosfs_access(const char * path, int mask)
{
	return 0;	
}

/**
 * Create a file.
 */
int qosfs_create(const char * path, mode_t mode, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Change the size of an open file.
 */
int qosfs_ftruncate(const char * path, off_t offset, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Get attributes form an open file.
 */
int qosfs_fgetattr(const char * path, struct stat * statbuf, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Initialize filesystem.
 */
void * qosfs_init(struct fuse_conn_info * conn)
{
}

/**
 * Destroy filesystem.
 */
void qosfs_destroy(void * userdata)
{
}

struct fuse_operations qosfs_operations =
{
	.getattr = qosfs_fgetattr,
	.readlink = qosfs_readlink,
	.getdir = NULL, /* deprecated */
	.mknod = qosfs_mknod,
	.unlink = qosfs_unlink,
	.rmdir = qosfs_rmdir,
	.symlink = qosfs_symlink,
	.rename = qosfs_rename,
	.link = qosfs_link,
	.chmod = qosfs_chmod,
	.chown = qosfs_chown,
	.truncate = qosfs_truncate,
	.utime = qosfs_utime,
	.open = qosfs_open,
	.read = qosfs_read,
	.write = qosfs_write,
	.statfs = qosfs_statfs,
	.flush = qosfs_flush,
	.release = qosfs_release,
	.fsync = qosfs_fsync,
	.opendir = qosfs_opendir,
	.readdir = qosfs_readdir,
	.releasedir = qosfs_releasedir,
	.fsyncdir = qosfs_fsyncdir,
	.init = qosfs_init,
	.destroy = qosfs_destroy,
	.access = qosfs_access,
	.create = qosfs_create,
	.ftruncate = qosfs_ftruncate,
	.fgetattr = qosfs_fgetattr,
};

int main(int argc, char ** argv)
{
	int i, fuse_stat;
	char * root_dir;

	openlog("QoSFS", LOG_PID|LOG_CONS, LOG_USER);
	syslog(LOG_INFO, "Mounting filesystem.");

	for (i = 1 ; i < argc && (argv[i][0] == '-') ; i++)
	{
		if  (i == argc)
		{
			return (-1);
		}
	}

	root_dir = realpath(argv[i], NULL);
	syslog(LOG_INFO, "Setting root dir: %s\n", root_dir);

	for(; i < argc ; i++)
	{
		argv[i] = argv[i+1];
	}

	argc--;

	fuse_stat = fuse_main(argc, argv, &qosfs_operations, NULL);

	syslog(LOG_INFO, "fuse_main returned %d\n", fuse_stat);

	closelog();

	return fuse_stat;
}

