#ifndef SCHEDULER_H
#define SCHEDULER_H

#define SC_DEADLINE 100.0

#include "acontroller.h"

// TODO
//char * high_priority_files[] = {};

struct rw_operation
{
	int id;
	enum op_type type;
	unsigned int priority;
};

/* Adds task to IO queue and waits for its turn */
int sc_wait(enum op_type, char * file);

int sc_init(struct ac_data data, unsigned int read, unsigned int write);

#endif
