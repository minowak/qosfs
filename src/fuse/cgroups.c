#include "include/cgroups.h"

#include <libcgroup.h>
#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>

int cgroup_initialize()
{
	int result = 0;

	if((result = cgroup_init()) != 0)
	{
		syslog(LOG_ERR, "cgroup_init() failed");
	}

	return result;
}

struct cgroup * cgroup_create(const char * name)
{
    char cgroup_path[256];
	struct cgroup * cgroup;
	sprintf(cgroup_path, "%s%s", CGROUP_PATH, name);
	
    if(mkdir(cgroup_path, 0777) < 0)
	{
		perror("mkdir");
		printf("%s", cgroup_path);
		syslog(LOG_ERR, "mkdir() failed");
		return NULL;
	}

	if((cgroup = cgroup_new_cgroup(name)) == NULL)
	{
		syslog(LOG_ERR, "cgroup_new_cgroup() failed");
		return NULL;
	}

	if(cgroup_create_cgroup(cgroup, 1) != 0)
	{
		syslog(LOG_ERR, "cgroup_create_cgroup() failed");
		return NULL;
	}
	
#ifdef DEBUG
	printf("[CG] Created cgroup: %s\n", name);
#endif
	
	return cgroup;
}

struct cgroup_controller * cgroup_create_controller(struct cgroup * cgroup)
{
	struct cgroup_controller * result;

	if((result = cgroup_add_controller(cgroup, CGROUP_CTRL)) == NULL)
	{
		syslog(LOG_ERR, "cgroup_add_controller() failed");
		return NULL;
	}

#ifdef DEBUG
	printf("[CG] Created controller: %s\n", CGROUP_CTRL);
#endif

	return result;
}

int cgroup_remove(struct cgroup * cgroup)
{
	int result;

	if((result = cgroup_delete_cgroup(cgroup, 1)) != 0)
	{
		syslog(LOG_ERR, "cgroup_delete_cgroup() failed");
	}

	return result;
}

int cgroup_set(struct cgroup_controller * controller, const char * param, const char * value)
{
	int result;
	if((result = cgroup_add_value_string(controller, param, value)) != 0)
	{
		syslog(LOG_ERR, "cgroup_set_value_string() failed");
	}

	return result;
}

int cgroup_classify(struct cgroup * cgroup, pid_t pid)
{
	int result;
	if((result = cgroup_attach_task_pid(cgroup, pid)) != 0)
	{
		syslog(LOG_ERR, "cgroup_attach_task_pid() failed");
	}

	return result;
}
