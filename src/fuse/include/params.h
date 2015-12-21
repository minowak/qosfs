#ifndef _PARAMS_H_
#define _PARAMS_H_

#define PATH_MAX 256
#define LOG_TAG "QoSFS"

#include "acontroller.h"

struct qosfs_data
{
	char * root_dir;
	char * cgroup_name;
	char * max_read_bytes;
	char * max_write_bytes;
	struct ac_data ac_data;
};

#endif
