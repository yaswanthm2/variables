#!/bin/bash

USERID=$(id -u)

if [$USERID==0]
    then
        DATE=$(date)
        echo " date is : $DATE"
    else 
       echo "please change the user to root"
fi    