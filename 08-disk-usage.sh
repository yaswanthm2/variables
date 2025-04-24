DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
 
R="\e[31m"
G="\e[32m"
N="\e[om"

USERID=$(id -u)

if [ $USERID -ne 0 ]
     then 
       echo -e " you need run this script with $R root user $N "
       exit 1
fi     

validate() {
    if [ $1 -ne 0 ]
      then 
         echo  -e "installation of $2 .... $R failure $N"
         exit 1
      else
         echo -e "installation of $2 .... $G success $N"
    fi     
}

for i in $@ 
    do 
       yum list installed | grep $i 

        if [ $? -ne 0 ] 
             then 
                yum install $i -y &>>$LOGFILE
                validate $?  $i               
             else
                echo -e  "$i is already $G installed $N"
        fi 
    done
