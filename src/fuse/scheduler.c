#include "include/scheduler.h"
#include "include/params.h"
#include "include/acontroller.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

struct rw_operation r_operations[N_OPS];
struct rw_operation w_operations[N_OPS];
volatile unsigned long last_index_r = 0;
volatile unsigned long last_index_w = 0;
volatile unsigned long op_id = 0;
pthread_mutex_t last_index_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t id_mutex = PTHREAD_MUTEX_INITIALIZER;
unsigned int read_speed, write_speed;
struct ac_data disk_data;

int sc_init(struct ac_data data, unsigned int read, unsigned int write)
{
	read_speed = read;
	write_speed = write;
	disk_data = data;
#ifdef DEBUG
	printf("[SC] Scheduler initialized\n");
#endif
	return 1;
}

int sc_remove(unsigned int id, enum op_type type)
{
	int i, j;

	struct rw_operation * operations;
	volatile unsigned long * last_index;
	if (type == READ) 
	{
		operations = r_operations;
		last_index = &last_index_r;
	} 
	else 
	{
		operations = w_operations;
		last_index = &last_index_w;
	}

	pthread_mutex_lock(&last_index_mutex);
	for(i = 0 ; i < *last_index ; i = i + 1)
	{
		struct rw_operation op = *(operations + i);
		if(op.id == id)
		{
			break;
		}
	}
	for(j = i + 1 ; j < *last_index ; j = j + 1)
	{
		*(operations + (j-1)) = *(operations + j);
	}
	*last_index = *last_index - 1;
	pthread_mutex_unlock(&last_index_mutex);

	return 1;
}

void * sc_checker(void * operation)
{
	int old_state, old_type;
	struct rw_operation * op = (struct rw_operation *) operation;
	int op_id = op->id;
	struct timeval t1, t2;
	double elapsed_time = 0.0;
	volatile unsigned long * last_index;
	struct rw_operation * operations;

	if (op->type == READ) 
	{
		operations = r_operations;
		last_index = &last_index_r;
	}
	else
	{
		operations = w_operations;
		last_index = &last_index_w;
	}

	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &old_state);
	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &old_type);

	gettimeofday(&t1, NULL);
	/* Checking for operation turn */
	while (1 && *last_index > 0) 
	{
		struct rw_operation first_op = operations[0];
		if(first_op.id == op_id)
		{
			break;
		}
		gettimeofday(&t2, NULL);
		elapsed_time = (t2.tv_usec - t1.tv_usec);
		if(elapsed_time < 0 || elapsed_time > SC_DEADLINE)
		{
			break;
		}
	}

	/* Checking for available disk load */
	while (elapsed_time > 0 && elapsed_time < SC_DEADLINE)
	{
		unsigned long speed = 0;
		if(op->type == READ)
		{
			speed = read_speed;
		} else 
		{
			speed = write_speed;
		}

		if(check_load_available(disk_data, speed, op->type))
		{
			break;
		}

		gettimeofday(&t2, NULL);
		elapsed_time = (t2.tv_usec - t1.tv_usec);

		pthread_testcancel();
	}

	return (void *) 1;
}

int sc_get_priority(const char * path)
{
	const char * hp_ext[] = HP_INITIALIZER;
	const char * mp_ext[] = MP_INITIALIZER;

	const char delimiter[2] = ".";
	char * token;
	char * extension;
	char * file;

	file = (char *)malloc(sizeof(char) * strlen(path));
	strcpy(file, path);

	token = strtok(file, delimiter);

	while(token != NULL)
	{
		extension = (char *)malloc(sizeof(char) * strlen(token));
		strcpy(extension, token);
		token = strtok(NULL, delimiter);
	}

	free(file);

	int i;
	for (i = 0 ; i < HP_SIZE ; i++)
	{
		if (!strcmp(extension, hp_ext[i])) 
		{
			return 1;
		}
	}

	for (i = 0 ; i < MP_SIZE ; i++)
	{
		if (!strcmp(extension, mp_ext[i]))
		{
			return 2;
		}
	}

	free(extension);

	return 3;
}

int sc_priority_compare(const void * op_a, const void * op_b)
{
	int _a = (* (struct rw_operation *) op_a).priority;
	int _b = (* (struct rw_operation *) op_b).priority;

	if(_a < _b)
	{
		return -1;
	} else 
	if(_a == _b)
	{
		return 0;
	} else 
	{
		return 1;
	}
}

int sc_recalculate()
{
	pthread_mutex_lock(&last_index_mutex);
	qsort(r_operations, last_index_r, sizeof(struct rw_operation), sc_priority_compare);
	qsort(w_operations, last_index_w, sizeof(struct rw_operation), sc_priority_compare);
	pthread_mutex_unlock(&last_index_mutex);
	return 1;
}

int sc_wait(enum op_type type, const char * file)
{
	struct rw_operation operation;
	volatile unsigned long * last_index;

	if (type == READ)
	{
		last_index = &last_index_r;
	}
	else
	{
		last_index = &last_index_w;
	}
	
	pthread_mutex_lock(&last_index_mutex);
	*last_index = *last_index + 1;
	pthread_mutex_unlock(&last_index_mutex);

	pthread_mutex_lock(&id_mutex);
	operation.id = op_id;
	op_id = op_id + 1;
	pthread_mutex_unlock(&id_mutex);

	operation.type = type;
	operation.priority = sc_get_priority(file);

	if (type == READ)
	{
		r_operations[*last_index] = operation;
	}
	else
	{
		w_operations[*last_index] = operation;
	}
        sc_recalculate();

	pthread_t checker;
	pthread_create(&checker, NULL, &sc_checker, (void *) &operation);

	pthread_join(checker, NULL);

	/* Delete completed operation from queue */
	sc_remove(operation.id, type);

	return 1;
}

