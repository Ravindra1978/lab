#!/bin/bash
#This program delete the files which are 2 weeks ago.
APP_LOGS_DIR=/home/ec2-user/app-logs
    LOGS_DIR=/home/ec2-user/shellscript-logs
    DATE=$(date +%F)
    SCRIPT_NAME=$0
    LOGFILE=$LOGS_DIR/$0-$DATE.log

FILES_TO_DELETE=$(find $APP_LOGS_DIR  -name "*.log" -type f -mtime +14)
echo "Files to delete are $FILES_TO_DELETE"

while read line
do 
   echo "Deleting $line" &>> $LOGFILE
   rm -rf $line
done <<< $FILES_TO_DELETE