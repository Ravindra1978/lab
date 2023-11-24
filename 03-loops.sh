DATE=$(date +%F)
LOGSDIR=/home/ec2-user/shellscript-logs
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
       echo -e "Installing $2.... is $R FAILURE....$N"
    else
       echo  -e "Installing $2... is $G SUCCESS...$N"
    fi
}
if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run the script with root user..$N"
    exit 1
fi
for i in $@
do 
  yum list installed $i &>>$LOGFILE
  if [ $? -ne 0 ]
  then
      echo -e "$G Package $i is not installed. Please install it....$N"
      yum install $i -y  &>>LOGFILE
      VALIDATE $? "$i"
  else
      echo -e "$R package $i is already installed....$N" 
  fi    
done