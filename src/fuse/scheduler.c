#include "include/scheduler.h"
#include "include/params.h"
#include "include/acontroller.h"
#include <pthread.h>

struct rw_operation[N_OPS]
// TODO MUTEXY
unsigned long last_index = 0;

int sc_wait(enum op_type type, char * file)
{
	struct rw_operation operation;
	last_index = last_index + 1;
	operation.id = last_index;
	operation.type = type;
	operation.priority = sc_get_priority(file);

	rw_operations[last_index] = operation;
    sc_recalculate();	

	// TODO wait (pthread join)
	pthread_t checker;
	pthread_create(&checker, NULL, &sc_checker, NULL);

	return 1;
}

int sc_get_priority(char * file)
{
	// TODO based on file types
	return 1;
}

int sc_recalculate()
{
	// TODO recalculate priorities, and sort rw_operations
	return 1;
}

int sc_checker()
{
	int old_state, old_type;

	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &old_state);
	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &old_type);

	while (1)
	{
		// TODO check free speed. If after a deadline there isnt enough, allow op anyway

		pthread_testcancel();
	}
}
