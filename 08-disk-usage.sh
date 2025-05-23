DATE=$(date +%F)
SCRIPT_FILENAME=$0
LOG_FILE=/tmp/$SCRIPT_FILENAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

THRESOLD=1

DISK_USAGE=$(df -hT | grep -vE -i 'tmpfs|filesystem' |awk '{print $6}' | cut -d % -f 1)

PARTION=$(df -hT | grep -vE -i 'tmpfs|filesystem' | awk '{print $1}'| )


while IFS= read line ;
      do 
         echo " $line " 
          if [ $line -gt 1 ]
                 then 
                    message+=" High disk usage on $PARTION : $line \n"

          fi           

      done <<<$DISK_USAGE



echo " $message "