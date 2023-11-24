#!/bin/bash
DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
USERID=$(id -u)
echo "scriptname is $SCRIPT_NAME"
echo "logfile value is $LOGFILE"
if [ $USERID -ne 0 ]
then
    echo "Please run the script with root user..."
    exit 1
fi
VALIDATE()
{
    if [ $1 -ne 0 ]
   then
      echo -e "Installing $2 is $R FAILURE...$N"
   else
      echo -e "Installing $2 is $G SUCCESS...$N"
  fi
}
   yum install mailxx -y &>> LOGFILE
   VALIDATE  $? "mailx" 
   yum install postfix -y &>> LOGFILE
   VALIDATE $? "postfix"

