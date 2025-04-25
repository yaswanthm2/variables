DATE=$(date +%F)
SCRIPT_FILENAME=$0
LOG_FILE=/tmp/$SCRIPT_FILENAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

THRESOLD=1

DISK_USAGE=$(df -hT | grep -vE -i 'tmpfs|filesystem' |awk '{print $6}' | cut -d % -f 1)

PARTION=$(df -hT | grep -vE -i 'tmpfs|filesystem' | awk '{print $1}')

 while read line 
     do 
        if [ $line -gt $THRESOLD ]
            then
               echo " HIGH DISK USAGE ON $PARTION : $line" &>>$LOG_FILE

     done <<< $DISK_USAGE
