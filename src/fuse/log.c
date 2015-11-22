/*
 * Logs errors to the file.
 */

#include "include/params.h"
#include "include/log.h"

#include <fuse.h>
#include <stdarg.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>


FILE * g_logfile = NULL;

/**
 * Opens file for logging.
 */
FILE * log_open()
{
	if (g_logfile == NULL)
	{
		g_logfile = fopen(LOGFILE, "w");
		if (g_logfile == NULL)
		{
			perror("logfile");
			exit(EXIT_FAILURE);
		}
	}

	return g_logfile;
}

/**
 * Logs message to logfile.
 */
void log_msg(const char * msg)
{
	fprintf(g_logfile, "[DATA] %s", msg);
}
