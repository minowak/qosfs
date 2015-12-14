#ifndef _CGROUPS_H_
#define _CGROUPS_H_

#include <stdio.h>
#include <sys/types.h>

#include <libcgroup.h>

#define CGROUP_CTRL "blkio"
#define CGROUP_RPARAM "throttle.read_bps_device"
#define CGROUP_WPARAM "throttle.write_bps_device"
#define CGROUP_PATH "/sys/fs/cgroup/blkio/"

/**
 * Initializes libcgroup.
 */
int cgroup_initialize(void);

/**
 * Creates new control group.
 * @param name group name
 */
struct cgroup * cgroup_create(const char * name);

/**
 * Creates controller BLKIO for given cgroup.
 * @param cgroup cgroup
 */
struct cgroup_controller * cgroup_create_controller(struct cgroup * cgroup);

/**
 * Removes control group.
 * @param name group name
 */
int cgroup_remove(struct cgroup * cgroup);

/**
 * Sets limits to cgroup blkio.
 * @param name cgroup name
 * @param param parameter name
 * @param value parameter value
 */
int cgroup_set(struct cgroup_controller * controller, const char * param, const char * value);

/**
 * Move process to cgroup.
 * @param name cgroup name
 * @param pid process id
 */
int cgroup_classify(struct cgroup * cgroup, pid_t pid);

#endif
