#!/bin/bash
#color &validatations
#log directions
DATE=$(date -u)
SCRIPT_NAME=$0
LOGFILE_DIR=/tmp
LOGFILE=$LOGFILE_DIR/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
VALIDATIION()
{
    if [ $1 -ne 0 ]
    then
        echo "Instalation of $2 is $R FAILURE.....$N"
    else
        echo "Instalatoion of $2 is $G SUCCESS...$N"
    fi
}
DISK_USAGE=$(df -hT | grep -vE 'tmpfs|Filesystem')
DISK_USAGE_THRESHOLD=1
#IFS--Internal Field Separator
while IFS= read line
do
    #this command will give disk usage in number format for comparision.
    $(df -hT | grep -vE 'tmpfs|Filesystem' | awk '{print $6}' | (cut -d % -f1)
done <<< $DISK_USAGE

