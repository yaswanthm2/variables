#!/bin/bash

DATE=$(date +%F)
SCRIPTFILE=$0
LOGFILE=/tmp/$SCRIPTFILE-$DATE-Deletedlogs



FILES_TO_DELETE=$(find /tmp/logs -type f -iname "*.log"  -mtime +14)

echo "FILE_TO_DELETE"