#ifndef _LOG_H_
#define _LOG_H_

#include <stdio.h>

FILE * log_open(void);
void log_msg(const char * format, ...);

#endif
