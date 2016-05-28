#!/bin/bash

for LOGFILE in *.log ;
	do mv $LOGFILE `echo $LOGFILE | sed 's/\(.*\.\)[0-9].log/\1log/'`
done

