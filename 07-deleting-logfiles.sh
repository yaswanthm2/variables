#!/bin/bash

DATE=$(date +%F)
SCRIPTFILE=$0
LOGFILE=/tmp/$SCRIPTFILE-$DATE-Deletedlogs
LOGFILEDR=/tmp/logs


FILES_TO_DELETE=$(find $LOGFILEDR -type f -iname "*.log"  -mtime  14)

echo "$FILES_TO_DELETE"
for line in ($FILES_TO_DELETE)
do
    echo "Line: $line"
done 