/*
 * QosFS: Filesystem with Quality of Service support
 *
 * gcc -Wall main.c `pkg-config fuse --cflags --libs` -o qosf
 *
 */

#include "include/params.h"
#include "include/cgroups.h"
#include "include/acontroller.h"

#include <sys/types.h>
#include <sys/stat.h>

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
#include <pthread.h>

#define LOG_CALL(F) (syslog(LOG_INFO, "%s() for %s", F, path))
#define LOG_ERROR(F) result = -errno;syslog(LOG_ERR, "error in %s() for %s", F, path)

static void fullpath(char fpath[PATH_MAX], const char * path)
{
	struct qosfs_data * private_data = (struct qosfs_data *) fuse_get_context()->private_data;
	strcpy(fpath, private_data->root_dir);
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
	if((result = lstat(fpath, statbuf)) < 0)
	{
		LOG_ERROR("getattr");
		syslog(LOG_ERR, "fpath in getattr = %s", fpath);
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
			}
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
 * Create a directory
 */
int qosfs_mkdir(const char * path, mode_t mode)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("mkdir");

	fullpath(fpath, path);
	if((result = mkdir(fpath, mode)) < 0)
	{
		LOG_ERROR("mkdir");
	}

	return result;
}

/**
 * Remove a file
 */
int qosfs_unlink(const char * path)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("unlink");

	fullpath(fpath, path);
	if((result =  unlink(fpath)) < 0)
	{
		LOG_ERROR("unlink");
	}

	return result;
}

/**
 * Remove a directory
 */
int qosfs_rmdir(const char * path)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("rmdir");

	fullpath(fpath, path);
	if((result = rmdir(path)) < 0)
	{
		LOG_ERROR("rmdir");
	}

	return result;
}

/**
 * Create a symbolic link
 */
int qosfs_symlink(const char * path, const char * link)
{
	int result = 0;
	char flink[PATH_MAX];

	LOG_CALL("symlink");

	fullpath(flink, link);
	if((result = symlink(path, flink)) < 0)
	{
		LOG_ERROR("symlink");
	}

	return result;
}

/**
 * Rename a file
 */
int qosfs_rename(const char * path, const char * new_path)
{
	int result = 0;
	char fpath[PATH_MAX];
	char fnew_path[PATH_MAX];

	LOG_CALL("rename");

	fullpath(fpath, path);
	fullpath(fnew_path, new_path);
	if((result = rename(fpath, fnew_path)) < 0)
	{
		LOG_ERROR("rename");
	}

	return result;
}

/**
 * Create a hard link
 */
int qosfs_link(const char * path, const char * new_path)
{
	int result = 0;
	char fpath[PATH_MAX];
	char fnew_path[PATH_MAX];

	LOG_CALL("link");

	fullpath(fpath, path);
	fullpath(fnew_path, new_path);
	if((result = link(fpath, fnew_path)) < 0)
	{
		LOG_ERROR("link");
	}

	return result;
}

/**
 * Change permissions/mode
 */
int qosfs_chmod(const char * path, mode_t mode)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("chmod");

	fullpath(fpath, path);
	if((result = chmod(fpath, mode)) < 0)
	{
		LOG_ERROR("chmod");
	}

	return result;
}

/**
 * Change owner/group
 */
int qosfs_chown(const char * path, uid_t uid, gid_t gid)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("chown");

	fullpath(fpath, path);
	if((result = chown(fpath, uid, gid)) < 0)
	{
		LOG_ERROR("chown");
	}

	return result;
}

/**
 * Check file permissions
 */
int qosfs_access(const char * path, int mask)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("access");

	fullpath(fpath, path);
	if((result = access(fpath, mask)) < 0)
	{
		LOG_ERROR("access");
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
	else
	{
		ffi->fh = (uint64_t) dp;
	}

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

	dp = (DIR *) ffi->fh;
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
 * Truncate a file
 */
int qosfs_truncate(const char * path, off_t new_size)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("truncate");

	fullpath(fpath, path);
	if((result = truncate(fpath, new_size)) < 0)
	{
		LOG_ERROR("truncate");
	}

	return result;
}

/**
 * Change the access/modification times of a file
 */
int qosfs_utime(const char * path, struct utimbuf * ubuf)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("utime");

	fullpath(fpath, path);
	if((result = utime(fpath, ubuf)) < 0)
	{
		LOG_ERROR("utime");
	}

	return result;
}

/**
 * Release directory
 */
int qosfs_releasedir(const char * path, struct fuse_file_info * ffi)
{
	LOG_CALL("releasedir");

	closedir((DIR *) ffi->fh);
	return 0;
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
 * Get FS statistics
 */
int qosfs_statfs(const char * path, struct statvfs * statv)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("statfs");

	fullpath(fpath, path);
	if((result = statvfs(fpath, statv)) < 0)
	{
		LOG_ERROR("statfs");
	}

	return result;
}

/**
 * Flush cached data.
 */
int qosfs_flush(const char * path, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Synchronize file contents.
 */
int qosfs_fsync(const char * path, int datasync, struct fuse_file_info * ffi)
{
	int result = 0;
	
	if((result = fsync(ffi->fh)) < 0 )
	{
		LOG_ERROR("fsync");
	}

	return result;
}

/**
 * Synchronize directory contents.
 */
int qosfs_fsyncdir(const char * path, int datasync, struct fuse_file_info * ffi)
{
	return 0;
}

/**
 * Create and open a file.
 */
int qosfs_create(const char * path, mode_t mode, struct fuse_file_info * ffi)
{
	int result = 0;
	char fpath[PATH_MAX];

	LOG_CALL("create");

	fullpath(fpath, path);

	if((result = creat(fpath, mode)) < 0)
	{
		LOG_ERROR("create");
	} 
	else
	{
		ffi->fh = result;
		return 0;
	}

	return result;
}

/**
 * Change the size of an open file.
 */
int qosfs_ftruncate(const char * path, off_t offset, struct fuse_file_info * ffi)
{
	int result = 0;

	LOG_CALL("ftruncate");

	if((result = ftruncate(ffi->fh, offset)) < 0)
	{
		LOG_ERROR("ftruncate");
	}

	return result;
}

/**
 * Get attributes from an open file.
 */
int qosfs_fgetattr(const char * path, struct stat * statbuf, struct fuse_file_info * ffi)
{
	int result = 0;

	LOG_CALL("fgetattr");

	if((result = fstat(ffi->fh, statbuf)) < 0)
	{
		LOG_ERROR("fgetattr");
	}

	return result;
}

/**
 * Initialize filesystem.
 */
void * qosfs_init(struct fuse_conn_info * conn)
{
	struct qosfs_data * data = (struct qosfs_data *) fuse_get_context()->private_data;
	char param[256];
	int bytes;
	struct stat * stat_buf;

	syslog(LOG_INFO, "init() called");
	syslog(LOG_INFO, "setting cgroup params: %sMb/s, %sMb/s", data->max_read_bytes, data->max_write_bytes);

	bytes = atoi(data->max_read_bytes);
	stat_buf = (struct stat *) malloc(sizeof(struct stat));
	stat(data->root_dir, stat_buf);
	bytes *= 1048576;
	sprintf(param, "%d:%d %d", major(stat_buf->st_dev), minor(stat_buf->st_rdev), bytes);

	cgroup_set(data->cgroup_name, CGROUP_RPARAM, param);
	bytes = atoi(data->max_write_bytes);
	bytes *= 1048576;
	cgroup_set(data->cgroup_name, CGROUP_WPARAM, param);

	return fuse_get_context()->private_data;
}

/**
 * Destroy filesystem.
 */
void qosfs_destroy(void * userdata)
{
	struct qosfs_data * data = (struct qosfs_data *) fuse_get_context()->private_data;
	syslog(LOG_INFO, "destroy() called");
	syslog(LOG_INFO, "removing cgroup");

	cgroup_remove(data->cgroup_name);
}

struct fuse_operations qosfs_operations =
{
	.readlink = qosfs_readlink,
	.getattr = qosfs_getattr,
	.mknod = qosfs_mknod,
	.create = qosfs_create,
	.unlink = qosfs_unlink,
	.rmdir = qosfs_rmdir,
	.symlink = qosfs_symlink,
	.link = qosfs_link,
	.rename = qosfs_rename,
	.chmod = qosfs_chmod,
	.chown = qosfs_chown,
	.access = qosfs_access,
	.utime = qosfs_utime,
	.statfs = qosfs_statfs,
	.flush = qosfs_flush,
	.truncate = qosfs_truncate,
	.fsync = qosfs_fsync,
	.fsyncdir = qosfs_fsyncdir,
	.fgetattr = qosfs_fgetattr,
	.ftruncate = qosfs_ftruncate,
	.getdir = NULL,
	.mkdir = qosfs_mkdir,
	.readdir = qosfs_readdir,
	.opendir = qosfs_opendir,
	.releasedir = qosfs_releasedir,
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
	struct qosfs_data * fs_data;
	char * max_read_bytes, * max_write_bytes;
	char cgroup_name[256];
	char device_name[256];
	pthread_t load_checker;

	openlog(LOG_TAG, LOG_PID|LOG_CONS, LOG_USER);
	syslog(LOG_INFO, "Mounting filesystem.");

	for (i = 1 ; i < 5 ; i++)
	{
		if (argv[i][0] == '-') {
#ifdef DEBUG
			printf("usage: %s [dir] [mountpoint] [max_read_bytes] [max_write_bytes] {[options]}\n", argv[0]);
#endif
			return EXIT_SUCCESS;
		}
	}

	max_read_bytes = argv[3];
	max_write_bytes = argv[4];

	for (i = 3 ; i < argc - 2; i++)
	{
		argv[i] = argv[i+2];
	}

	argc -= 2;

	for (i = 1 ; i < argc && (argv[i][0] == '-') ; i++)
	{
		if  (i == argc)
		{
			return (-1);
		}
	}

	if((fs_data = malloc(sizeof(struct qosfs_data))) == NULL) 
	{
		perror("fs_data malloc");
		syslog(LOG_ERR, "Malloc for fs_data");
		closelog();
		abort();
	}

	sprintf(cgroup_name, "qosfs_%d", getpid());

	syslog(LOG_INFO, "Creating cgroup %s", cgroup_name);
	cgroup_init();
	cgroup_create(cgroup_name);
	cgroup_classify(cgroup_name, getpid());

	get_disk_data(&(fs_data->ac_data));

	fs_data->root_dir = realpath(argv[i], NULL);
    fs_data->cgroup_name = cgroup_name;
	fs_data->max_read_bytes = max_read_bytes;
	fs_data->max_write_bytes = max_write_bytes;
	syslog(LOG_INFO, "Setting root dir: %s", fs_data->root_dir);

	for(; i < argc ; i++)
	{
		argv[i] = argv[i+1];
	}

	argc--;
	get_device_name(fs_data->root_dir, device_name);
	pthread_create(&load_checker, NULL, &disk_load_checker, device_name);
	fuse_stat = fuse_main(argc, argv, &qosfs_operations, fs_data);
	pthread_cancel(load_checker);

	syslog(LOG_INFO, "fuse_main returned %d", fuse_stat);

	closelog();

	return fuse_stat;
}

