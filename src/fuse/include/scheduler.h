#ifndef SCHEDULER_H
#define SCHEDULER_H

#define SC_DEADLINE 100.0

#define HP_SIZE 9
#define MP_SIZE 5
#define HP_INITIALIZER {"webm", "mkv", "flv", "vob", "ogg", "avi", "mov", "mpg", "mpeg"}
#define MP_INITIALIZER {"jpg", "tiff", "gif", "png", "bmp"}

#include "acontroller.h"

struct rw_operation
{
	int id;
	enum op_type type;
	unsigned int priority;
};

/* Adds task to IO queue and waits for its turn */
int sc_wait(enum op_type, const char * file);

int sc_init(struct ac_data data, unsigned int read, unsigned int write);

#endif
