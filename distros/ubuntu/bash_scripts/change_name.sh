#!/bin/bash 
#Author: Ing. Armando Ibarra
#Email: armandoibarra1@gmail.com
#Date: 29/11/2013 
#Purpose: Auto Hostname Changing clear echo "Please Enter your Desired Hostname" 

#http://superuser.com/questions/305939/bash-lookup-an-ip-for-a-host-name-including-etc-hosts-in-search
ipfor() 
{
  ping -c 1 $1 | grep -Eo -m 1 '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
}

#http://it.megocollector.com/?p=1952

THISHOST=$(hostname)
DIR_ARSYNC=$HOME/.armando-rsync
HOSTNAME_TMP=$HOME/.armando-rsync/hostname
HOSTS_TMP=$HOME/.armando-rsync/hosts

[ "$(whoami)" != 'root' ] && ( echo "########## WARNING: you are using a non-privileged account"; exit 1 )

#Searhc if exist file (Just debian based distro)
if [ -f /etc/hostname ];then
        echo "Begin change hostname: ------------->  ${THISHOST}" 
fi

#http://linuxgazette.net/issue38/tag/6.html
echo "---------------------------------------"
echo "Please input new name: "
read HOSTNAME
echo "Change hostname odl: ${THISHOST} TO ${HOSTNAME}"

if [ ! -d "$DIR_ARSYNC" ]; then
                        # Control will enter here if $DIRECTORY exists.
                        echo "Try to Make DIRECTORY"
			mkdir $DIR_ARSYNC

			if cd $DIR_ARSYNC; then
				DIR_SCH=$PWD
		                echo $DIR_SCH
			else 
				echo "ERROR ------------------"
				exit

			fi

	  	        chown $USER -R $DIR_ARSYNC
		        chmod 775 -R $DIR_ARSYNC
                       # sudo mkdir /usr/local/man/man1
else

                        echo "exist ${DIR_ARSYNC}"
fi


	echo "Try to change hostname .."
        H=$(cat /etc/hostname)
        sudo cp /etc/hostname $HOSTNAME_TMP.backup
        sudo cp /etc/hosts $HOSTS_TMP.backup

        #http://askubuntu.com/questions/9540/how-do-i-change-the-computer-name
        touch $HOSTNAME_TMP
        touch $HOSTS_TMP
	cat /etc/hostname > $HOSTNAME_TMP
	cat /etc/hosts > $HOSTS_TMP

        #echo "${HOSTNAME}" > $HOSTNAME_TMP

	echo "Aply changes ...."

	if [ ! -f $HOSTNAME_TMP ];then
		echo "Eroor Hostname"
		exit
	fi	

	if [ ! -f $HOSTS_TMP ];then
		echo "Eroor DNS"
		exit
	fi	
	
	#exit

	#http://plagatux.es/2010/03/bash-script-trabajando-en-sed-con-variables-bash/
	#http://stackoverflow.com/questions/7033860/bash-script-using-sed-with-variables-in-a-for-loop
	echo "changed $THISHOST ----------------> $HOSTNAME   on $HOSTNAME_TMP"
	sed -i 's/'$THISHOST'/'$HOSTNAME'/g' $HOSTNAME_TMP

	if [ $? -ne 0 ]; then
	         echo "No se pudo aplicar cambio hostname"
        	exit
	else
        	echo "OK"
	fi

	echo "changed $THISHOST ----------------> $HOSTNAME   on $HOSTS_TMP"
	sed -i 's/'$THISHOST'/'$HOSTNAME'/g' $HOSTS_TMP

	if [ $? -ne 0 ]; then
        	 echo "No se pudo aplicar cambio hostname"
	         exit
	else
        	echo "OK"
	fi

	#cat $HOSTNAME_TMP
	#cat $HOSTS_TMP
	#CONT=1

	HN_NO=$(grep -c "$HOSTNAME" $HOSTNAME_TMP)
	HS_NO=$(grep -c "$HOSTNAME" $HOSTS_TMP)

	echo $HN_NO

	echo "-----------"

	echo $HS_NO
	#http://www.the-evangelist.info/2009/12/bash-operadores-de-comparacion/
	#http://blog.desdelinux.net/programando-en-bash-parte-2/
	#http://gnulinuxricardo.blogspot.mx/2012/08/comparacion-de-2-cadenas-en-shellscript.html
	#$CONT -lt 10
	if [ $HN_NO -ge 1 ];then 
		echo "ok"	
	else
		echo "Error no changes hostname"
		exit
	fi
	
	#grep -c "$HOSTNAME" $HOSTS_TMP

	if [ $HS_NO -ge 1 ];then 
		echo "ok"
        else
                echo "Error no changes -- hosts"
                exit
        fi

	 if [ $HN_NO -ge 1 ] && [ $HS_NO -ge 1 ]; then

		sudo mv $HOSTNAME_TMP /etc/hostname

		sudo mv $HOSTS_TMP /etc/hosts

		echo "Complete changed name"

	 fi

exit
