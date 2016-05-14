#ifndef _ACONTROLLER_H_
#define _ACONTROLLER_H_

struct ac_data
{
	unsigned int disk_read_speed;
	unsigned int disk_write_speed;
};

enum op_type
{
	READ,
	WRITE
};

/**
 * Checks if device has available load.
 */
int check_load_available(struct ac_data, unsigned int bytes, enum op_type load);

/**
 * Returns maximum possible disk read speed (in bytes/s).
 * @param dev block device name (eg. sda)
 */
int get_disk_data(struct ac_data * data);

/**
 * Thread for checking current disk load;
 * It reads from /sys/block/sdX/stat every second and calculates current disk I/O usage.
 * @param dev block device name (eg. sda)
 */
void * disk_load_checker(void * dev);

/**
 * Returns current disk load.
 * @param load load type (read or write).
 */
int get_current_load(enum op_type load);

/**
 * Returns debice name for given path.
 * @param root_dir path
 * @param dev device name
 */
int get_device_name(const char * root_dir, char * dev);

#endif
