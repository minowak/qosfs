#ifndef _CGROUPS_H_
#define _CGROUPS_H_

#include <stdio.h>
#include <sys/types.h>

#define CGROUP_CTRL "blkio"
#define CGROUP_RPARAM "throttle.read_bps_device"
#define CGROUP_WPARAM "throttle.write_bps_device"

/**
 * Initializes cgroup library; should be called befory any interactions ith cgroups.
 */
int cgroup_init();

/**
 * Creates new control group.
 * @param name group name
 */
int cgroup_create(const char * name);

/**
 * Removes control group.
 * @param name group name
 */
int cgroup_remove(const char * name);

/**
 * Sets limits to cgroup blkio.
 * @param name cgroup name
 * @param param parameter name
 * @param value parameter value
 */
int cgroup_set(const char * name, const char * param, const char * value);

/**
 * Move process to cgroup.
 * @param name cgroup name
 * @param pid process id
 */
int cgroup_classify(const char * name, pid_t pid);

#endif
