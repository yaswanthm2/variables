#!/bin/bash

DATE=$(date +%F)
SCRIPT_NAME=$0
LOG_FILE=/tmp/$SCRIPT_NAME-$DATE.log


R="\e[31m"
G="\e[32m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]
    then 
       echo -e " Please run script with $R root user $N "
       exit -1
    else 
       echo -e "script is Running $G with sudo access $N "
fi

validate(){

    if [ $1 -ne 0 ]
      then 
        echo -e " $2 ....$R FAILURE $N "
        exit 1
       else
         echo -e " $2 .... $G SUCCESS $N"
    fi
}

yum update -y --exclude=kernel* &>> $LOG_FILE

validate  $? "Updating yum package" 

yum -y install postfix cyrus-sasl-plain mailx &>> $LOG_FILE

validate  $? Installing postfix sasl-auth mailx 

systemctl restart postfix  &>> $LOG_FILE

validate $? "restarting postfix" 

systemctl enable postfix  &>> $LOG_FILE

validate $? "enabling postfix"

sed -i '$ a\
relayhost = [smtp.gmail.com]:587\
smtp_use_tls = yes\
smtp_sasl_auth_enable = yes\
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd\
smtp_sasl_security_options = noanonymous\
smtp_sasl_tls_security_options = noanonymous' /etc/postfix/main.cf &>> $LOG_FILE

validate $?  " adding lines into config file "

read -s -p "Enter username: " username

read -s -p "Enter password: " password 

cp  /home/ec2-user/scripts-learning/variables/sasl_passwd  /etc/postfix/sasl_passwd

sed -i 's/username/$username/' 's/password/$password/' /etc/postfix/sasl_passwd

validate $? " giving username password to sasl "

postmap /etc/postfix/sasl_passwd 





