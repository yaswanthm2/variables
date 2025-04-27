#!/bin/bash

DATE=$(date =%F)
SCRIPT_NAME=$0
LOG_FILE=/tmp

R="\e[31m"
G="\e[32m"
N="\e[0m"

USERID=$(id -u)

if [ $? -ne 0 ]
    then 
       echo -e " Please run script with $R root user $N "
       exit -1
    else 
       echo -e "script is Running $R with sudo access $N "
fi

validate(){

    if [ $1 -ne 0 ]
      then 
        echo " $2 .... FAILURE "
        exit 1
       else
         echo " $2 .... SUCCESS "
    fi
}

yum update -y --exclude=kernel* 

validate  $? "Updating yum package" 

yum -y install postfix cyrus-sasl-plain mailx 

validate  $? Installing postfix sasl-auth mailx 

systemctl restart postfix 

validate $? "restarting postfix"

systemctl enable postfix 

validate $? "enabling postfix"

sed -i '$ a\
relayhost = [smtp.gmail.com]:587\
smtp_use_tls = yes\
smtp_sasl_auth_enable = yes\
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd\
smtp_sasl_security_options = noanonymous\
smtp_sasl_tls_security_options = noanonymous' /etc/postfix/main.cf

validate $1  " adding lines into config file "





