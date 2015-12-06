#ifndef _ACONTROLLER_H_
#define _ACONTROLLER_H_

enum load 
{
	READ,
	WRITE
};

struct ac_data
{
	unsigned int disk_read_speed;
	unsigned int disk_write_speed;
};

/**
 * Checks if device has available read load.
 */
int check_read_available(struct ac_data, unsigned int bytes);

/**
 * Checks if device has available read load.
 */
int check_write_available(struct ac_data, unsigned int bytes);

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
double get_current_load(enum load load);

/**
 * Returns debice name for given path.
 * @param root_dir path
 * @param dev device name
 */
int get_device_name(const char * root_dir, char * dev);

#endif
