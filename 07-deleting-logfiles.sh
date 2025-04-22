#!/bin/bash

DATE=$(date +%F)
SCRIPTFILE=$0
LOGFILE=/tmp/$SCRIPTFILE-$DATE-Deletedlogs
LOGFILEDR=/tmp/logs


FILES_TO_DELETE=$(find $LOGFILEDR -type f -iname "*.log"  -mtime  14)

echo "$FILES_TO_DELETE"
