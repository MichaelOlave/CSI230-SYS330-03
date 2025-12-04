#!/bin/bash

LOGFILE="logaccessfile.txt"
TARGET="userlog.bash"

echo "File accessed $(date)" >> "$LOGFILE"

{
	echo "Subject: Access Log"
	echo
	cat $LOGFILE
} | ssmtp michael.olave@mymail.champlain.edu
