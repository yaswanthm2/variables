#!/bin/bash

R="\e[31m"   #it will give text red color 
G="\e[32m"    #it will give text green color 
N="\e[0m"     #it will give text normal color 

SCRIPTNAME=$0     # $0 give script file name to that variable  
DATE=$(date +%F-%H:%M:%S)   
LOGFILE=/tmp/$SCRIPTNAME-$DATE.log    # this is the path where log files are stored
USER=$(id -u)

if [ $USER -ne 0 ]
  then
    echo -e "please change user to $R sudo user $N"
    exit 1
  else
    echo -e "$G user is root user $N"
fi

validate(){
    if [ $1 -ne 0 ]
    then
       echo  -e "$R $2 ...  failure $N"
       exit 1
    else
       echo -e "$G $2 ... sucess $N"
    fi            
}

for i in $@   # $@ it refers all the arguments you are giving while executing script 
   do 
     yum install $i -y &>>$LOGFILE 
     validate $?  "Installing $i"     # $? it is exit status code means if command is succes it give 0 value if not it will give 1-127
   done




