#ifndef _ACONTROLLER_H_
#define _ACONTROLLER_H_

#define AC_TESTFILE ".loadtest"

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

#endif
