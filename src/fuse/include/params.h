#ifndef _PARAMS_H_
#define _PARAMS_H_

#define PATH_MAX 256
#define LOG_TAG "QoSFS"

#define N_SECOND 10000
#define N_PARTS 5

#include "acontroller.h"

struct qosfs_data
{
	char * root_dir;
	char * max_read_bytes;
	char * max_write_bytes;
	struct ac_data ac_data;
};

#endif
