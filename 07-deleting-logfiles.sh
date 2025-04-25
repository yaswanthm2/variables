#!/bin/bash
 
DATE=$(date +%F)
LOGFILE_DIR=/home/ec2-user/logs
LOGFILE=$LOGFILE_DIR/$SCRIPT_NAME-$DATE.log
SCRIPTNAME=$0



FILES=$(find $LOGFILE_DIR -type f -name "*.log"  -mtime +14)

while read line 
  do 
    echo "Deleting file $line" &>>$LOGFILE
    rm -rf $line 
  done < $FILES


