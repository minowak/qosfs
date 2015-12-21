#include "include/cgroups.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>

char cgroup_mount_point[256];

int cgroup_init()
{
	int result = 0;
	size_t len = 0;
	ssize_t read;
	int found = 0;
	char * line = NULL;
	FILE * fp;

	if((fp = fopen("/proc/mounts", "r")) == NULL)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_init() failed");
		return result;
	}

	while(!found && ((read = getline(&line, &len, fp)) != -1))
	{
		char * tok = strtok(line, " ");
		while(!found && tok != NULL)
		{
			char suffix[32];
			sprintf(suffix, "cgroup/%s", CGROUP_CTRL);
			size_t len_str = strlen(tok);
			size_t len_suffix = strlen(suffix);
			if (len_suffix <= len_str)
			{
				if(strncmp(tok + len_str - len_suffix, suffix, len_suffix) == 0)
				{
					strcpy(cgroup_mount_point, tok);
					found = 1;
				}
			}

			tok = strtok(NULL, " ");
		}

	}

	fclose(fp);
	if(line)
	{
		free(line);
	}

#ifdef DEBUG
	printf("[CG] Cgroups initialized. Mount point: %s\n", cgroup_mount_point);
#endif

	return result;
}

int cgroup_create(const char * name)
{
    char cgroup_path[256];
	int result = 0;

	sprintf(cgroup_path, "%s/%s", cgroup_mount_point, name);
	
    if(mkdir(cgroup_path, 0777) < 0)
	{
		result = -errno;
		perror("mkdir");
		printf("%s", cgroup_path);
		syslog(LOG_ERR, "mkdir() failed");
		return result;
	}
	
#ifdef DEBUG
	printf("[CG] Created cgroup: %s\n", name);
#endif
	
	return result;
}

int cgroup_remove(const char * name)
{
	int result;
	char cgroup_path[256];

	sprintf(cgroup_path, "%s/%s", cgroup_mount_point, name);

	if(rmdir(cgroup_path) != 0)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_remove() failed");
	}

#ifdef DEBUG
	printf("[CG] removed contrl group: %s\n", name);
#endif

	return result;
}

int cgroup_set(const char * name, const char * param, const char * value)
{
	int result = 0;
	char cgroup_path[256];
	FILE *fp;

	sprintf(cgroup_path, "%s/%s/%s.%s", cgroup_mount_point, name, CGROUP_CTRL, param);

	if((fp = fopen(cgroup_path, "w")) == NULL)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_set() failed");
		return result;
	}

	if(fputs(value, fp) != 0)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_set() failed");
		fclose(fp);
		return result;
	}

	fclose(fp);
#ifdef DEBUG
	printf("[CG] Set params for group: %s\n", name);
#endif

	return result;
}

int cgroup_classify(const char * name, pid_t pid)
{
	int result = 0;
	char s_pid[16];
	char cgroup_path[256];
	FILE *fp;

	sprintf(cgroup_path, "%s/%s/tasks", cgroup_mount_point, name);

	if((fp = fopen(cgroup_path, "w")) == NULL)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_classify() failed");
		return result;
	}

	sprintf(s_pid, "%d", pid);
	if(fputs(s_pid, fp) != 0)
	{
		result = -errno;
		syslog(LOG_ERR, "cgroup_classify() failed");
		return result;
	}

#ifdef DEBUG
	printf("[CG] Classified process with pid: %d\n", pid);
#endif

	return result;
}
