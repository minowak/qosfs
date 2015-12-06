#include "include/acontroller.h"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>

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
