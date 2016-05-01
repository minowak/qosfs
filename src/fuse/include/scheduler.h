#ifndef SCHEDULER_H
#define SCHEDULER_H

enum op_type
{
	READ,
	WRITE
};

struct rw_operation
{
	int id;
	enum op_type type;
	unsigned int priority;
};

/* Adds task to IO queue and waits for its turn */
int sc_wait(enum op_type, char * file);

#endif
