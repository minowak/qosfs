#include "include/acontroller.h"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>

unsigned int read_load = 0;
unsigned int write_load = 0;

pthread_mutex_t read_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t write_mutex = PTHREAD_MUTEX_INITIALIZER;

void * disk_load_checker(void * dev)
{
	int last_read_bytes, last_write_bytes;
	int old_state, old_type;
	char * dev_name = (char *) dev;
	char root_dev[4];
	char stat_file_path[256];

	memcpy(root_dev, &dev_name[5], 3);
	root_dev[3] = '\0';
	sprintf(stat_file_path, "/sys/block/%s/stat", root_dev);
	// We need 3rd and 7th column (read/write sectors) and multiply by 512 to get bytes.

#ifdef DEBUG
	printf("[AC] Starting load checker thread for %s (%s)\n", dev_name, root_dev);
#endif

	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &old_state);
	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &old_type);

	while (1)
	{
		FILE * fp;
		int read_bytes_increment, write_bytes_increment;

		if((fp = fopen(stat_file_path, "r")) != NULL)
		{
			char val[32];
			int i, read_bytes, write_bytes;
			for (i = 0 ; i < 11 ; i++)
			{
				fscanf(fp, "%s", val);
				if (i == 2)
				{
					read_bytes = atoi(val);
				} else if (i == 6)
				{
					write_bytes = atoi(val);
				}
			}

			read_bytes_increment = (read_bytes - last_read_bytes) * 512;
			write_bytes_increment = (write_bytes - last_write_bytes) * 512;

			last_read_bytes = read_bytes;
			last_write_bytes = write_bytes;
			fclose(fp);
		}

                pthread_mutex_lock(&read_mutex);
		pthread_mutex_lock(&write_mutex);
		
		read_load = (unsigned int)(read_bytes_increment / 1024);
		write_load = (unsigned int)(write_bytes_increment / 1024);
		pthread_mutex_unlock(&read_mutex);
		pthread_mutex_unlock(&write_mutex);

		sleep(1);
		pthread_testcancel();
	}

	return NULL;
}

int get_current_load(enum load load)
{
	int result = 0;
	switch (load)
	{
		case READ:
			pthread_mutex_lock(&read_mutex);
			result = read_load;
			pthread_mutex_unlock(&read_mutex);
			break;
		case WRITE:
			pthread_mutex_lock(&write_mutex);
			result = write_load;
			pthread_mutex_unlock(&write_mutex);
			break;
	}

#ifdef DEBUG
	printf("[LC] Getting load for %d: %d\n", load, result);
#endif

	return result;
}

int check_load_available(struct ac_data data, unsigned int bytes, enum load load)
{
	int result;
	unsigned int current_load = get_current_load(load);		
	unsigned int disk_speed; 
	unsigned int required_kb = bytes * 1024;
	
	switch(load)
	{
        	case READ:
                	disk_speed = (int)(data.disk_read_speed * 1024);
                	break;
        	case WRITE:
        	        disk_speed = (int)(data.disk_write_speed * 1024);
        	        break;
	}

	if (disk_speed - current_load >= required_kb)
	{
		result = 1;
	} else
	{
		result = 0;
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
#ifdef DEBUG
		printf("[AC] Disk write speed: %sMb/s\n", response);
#endif
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
#ifdef DEBUG
		printf("[AC] Disk read speed: %sMb/s\n", response);
#endif
		fclose(fp);
		data->disk_read_speed = atoi(response);
	} else
	{
		return -errno;
	}

	remove("/tmp/output");

	return EXIT_SUCCESS;
}

int get_device_name(const char * root_dir, char * dev)
{
	int result;
	FILE * fp;
	char cmd[256];

	sprintf(cmd, "df %s | tail -n1 | awk '{print $1}'", root_dir);
	if ((fp = popen(cmd, "r")) != NULL)
	{
		fscanf(fp, "%s", dev);
		fclose(fp);
	} else 
	{
		result = -errno;
	}

	return result;
}

