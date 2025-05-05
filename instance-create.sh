#!/bin/bash

R="\e[31m"    #it will give text red color 
G="\e[32m"    #it will give text green color 
N="\e[0m"     #it will give normal color to text 

IMAGE_ID=
INSTANCE_TYPE=
SECURITY_GROUP_IP=

DATE=$(date +%F)
SCRIPTFILE_NAME=$0
LOG_FILE=/tmp/$SCRIPTFILE_NAME-$DATE.log
INSTANCE_TYPE=""

INSATNCES_NAMES=("mongodb" "cart" "app" "mysql")

for i in ${INSATNCES_NAMES[@]}
   do 
      if [[ $i == mongodb || $i == mysql ]];
        then 
          INSTACE_TYPE="t3.micro"
        else
          INSTANCE_TYPE="t2.micro"
      fi 
    echo " creating instace $i "

    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-groups-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jg -r '.Instances[0].PrivateIpAddress')  

    echo " created $i instance IP : $IP_ADDRESS "

    done

