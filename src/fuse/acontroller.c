#include "include/acontroller.h"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>
#include <pthread.h>

double read_load = 0.0;
double write_load = 0.0;

pthread_mutex_t read_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t write_mutex = PTHREAD_MUTEX_INITIALIZER;

void * disk_load_checker(void * dev)
{
	int last_read_bytes, last_write_bytes;
	int old_state, old_type;
	char * dev_name = (char *) dev;

	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &old_state);
	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &old_type);

	while (1)
	{
		sleep(1);
		pthread_testcancel();
	}

	return NULL;
}

double get_current_load(enum load load)
{
	double result = 0.0;
	switch (load)
	{
		case READ:
			pthread_mutex_lock(&read_mutex);
			result = read_load;
			pthread_mutex_unlock(&read_mutex);
			break;
		case WRITE:
			pthread_mute_lock(&write_mutex);
			result = write_load;
			pthread_mutex_unlock(&write_mutex);
			break;
	}

	return result;
}

int get_disk_data(struct ac_data * data)
{
	FILE *fp;
	if ((fp = popen("dd if=/dev/zero of=/tmp/output bs=250k count=1024 oflag=direct \
					2>&1 | tail -n1 | awk '{print $8}'", 
					"r")) != NULL)
	{
		char response[32];
		fscanf(fp, "%s", response);
		printf("[AC] Disk write speed: %sMb/s\n", response);
		fclose(fp);
		data->disk_write_speed = atoi(response);
	} else 
	{
		return -errno;
	}

	// Clear cache
	if ((fp = popen("/sbin/sysctl -w vm.drop_caches=3", "r")) == NULL)
	{
		return -errno;
	} else
	{
		fclose(fp);
	}

	if ((fp = popen("dd if=/tmp/output of=/dev/null bs=250k count=1024 iflag=direct \
					2>&1 | tail -n1 | awk '{print $8 }'", "r")) != NULL)
	{
		char response[32];
		fscanf(fp, "%s", response);
		printf("[AC] Disk read speed: %sMb/s\n", response);
		fclose(fp);
		data->disk_read_speed = atoi(response);
	} else
	{
		return -errno;
	}

	remove("/tmp/output");

	return EXIT_SUCCESS;
}
