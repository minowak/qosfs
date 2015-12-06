#include "include/cgroups.h"
#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <unistd.h>

int cgroup_create(const char * name)
{
	char cmd[256];
	char uname[256];
	int result;

	if((result = getlogin_r(uname, sizeof(uname))) < 0)
	{
		syslog(LOG_ERR, "getlogin_r() failed");
	}

	sprintf(cmd, "cgcreate -a %s -g %s:%s", uname, CGROUP_CTRL, name);
	if((result = system(cmd)) != 0)
	{
		syslog(LOG_ERR, "cgcreate failed");
	}

	return result;
}

int cgroup_remove(const char * name)
{
	char cmd[256];
	int result;

	sprintf(cmd, "cgdelete -g %s:%s", CGROUP_CTRL, name);
	if((result = system(cmd)) != 0)
	{
		syslog(LOG_ERR, "cgdelete failed");
	}

	return result;
}

int cgroup_set(const char * name, const char * param, const char * value)
{
	char cmd[256];
	int result;

	sprintf(cmd, "cgset -r %s.%s=%s %s", CGROUP_CTRL, param, value, name);
	if((result = system(cmd)) != 0)
	{
		syslog(LOG_ERR, "cgset failed");
	}

	return result;
}
