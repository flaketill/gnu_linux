#!/usr/bin/env sh
# -*- coding: UTF-8 -*- 
# Copyright (C) 2014 Armando Ibarra
#  v0.1 alpha - 2014
# 

#----------------------------------------------------------------------
# ubuntu wps español 
#
# Author: Ing. Armando Ibarra - armandoibarra1@gmail.com
# Email: armandoibarra1@gmail.com
# Date: 13/06/2014 
# Purpose:
#    Performs the install wps lenguages (like spanish)
#    this shell script try to install depencences 
#    on linux OS, invokes some system commands like
#    sudo, pacman, apt-get install, etc
#
#----------------------------------------------------------------------
# NOTES:    
#----------------------------------------------------------------------
#	 I prefer LibreOffice but if you want use wps on spanish this bash 
#    script can help you

#    Test on Archlinux,ubuntu 13.10 and Xubuntu 14.04
#----------------------------------------------------------------------

###############################################################################

# Licensed under the GNU GPL v3 - http://www.gnu.org/licenses/gpl-3.0.txt
# - or any later version.

# WPS install languages
# A bash script installing/building all needed dependencies to 
# build wps languages for just some Linux distributions.

# @author: Ing. Armando Ibarra

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

###############################################################################

#variables

#autor and project data
AUTHOR='Ing. Armando Ibarra <armandoibarra1@gmail.com>'
COPYRIGHT='Copyright (c) 2014, armandoibarra1@gmail.com'
LICENSE='GNU GPL Version 3'

WEB_SITE="https://github.com/erpmtics/erpmtics"
VERSION_SCRIPT="0.0.1 alpha"

#colors bash script
GREEN="\033[1;32m"
RESET="\033[0m"
WHITE="\033[1;37m"
BLUE="\033[1;34m"
RED="\033[1;31m"

THIS_SCRIPT_PATH=`readlink -f $0`
THIS_SCRIPT_DIR=`dirname ${THIS_SCRIPT_PATH}`
TMP_CONF=$HOME"/.erpmtics"

PATH_CLONE="$TMP_CONF/wps_i18n"
PATH_CLONE_ES="$TMP_CONF/wps_i18n/es"

PATH_TO_ZIP=$HOME"/.kingsoft/mui/es"
PATH_ES_ZIP=$HOME"/.kingsoft/mui/"

B_CONF_PACMAN="$TMP_CONF/pacman.conf.old"
#454

#Downloads
DEB="wps.deb"
WPS_DEB="http://kdl.cc.ksosoft.com/wps-community/kingsoft-office_9.1.0.4280~a12p4_i386.deb"
PATH_DEB=$THIS_SCRIPT_DIR"/$DEB"

#Repos data (This repo contain internationalization support)
URL_GIT_REPO="https://github.com/wps-community/wps_i18n"

#http://wps-community.org/download/dicts/

#1) (from web) Download The Spellcheck Zip Install Package, e.g.: en-US.zip
#2) (from WPS) Review --> Set Spellcheck Language --> Install, and choose en-US.zip
ULR_ES="http://wps-community.org/download/dicts/es_ES.zip"

#arch https://aur.archlinux.org/packages.php?ID=16974
DEPENDENCIES_ARCH="none"
DEPENDENCIES="sudo curl axel wget ssh"

DEPS_ALT="YES"

DISTROS_SUPPORT="Arch Ubuntu Debian"
DISTRO="none"
PACKAGE_MANAGER="none"

#packages on pacman, apt-get etc
#https://aur.archlinux.org/packages/wpsforlinux/
ARCH_WPS="wpsforlinux" #https://aur.archlinux.org/packages/kingsoft-office/"
CONF_PACMAN="/etc/pacman.conf"
URL_DEB_ALT="http://kdl.cc.ksosoft.com/wps-community/kingsoft-office_9.1.0.4280~a12p4_i386.deb"

PATH_WPS="/opt/kingsoft/wps-office/"

UBUNTU_WPS="none"
PKG_WPS="none"

INSTALL_DEB="none"

if [ ! -d ~/.config/erpmtics ]; then
	mkdir ~/.config/erpmtics
fi

if [ -f ~/.config/erpmtics/erpmticsrc ]; then
	source ~/.config/erpmtics/erpmticsrc
else

	DATEFMT=%Y%m%d-%H%M
	BACKUP_DIR="/tmp"
	EDITOR=nano
fi

#git clone https://codeload.github.com/wps-community/wps_i18n

#wget https://codeload.github.com/wps-community/wps_i18n/zip/master

# An error exit function

error()
{

	echo -e "$RED ${PROGNAME}: ${1:-"Unknown Error"} $RESET" 1>&2

}

error_exit()
{

	echo -e "$RED ${PROGNAME}: ${1:-"Unknown Error"} $RESET" 1>&2
	exit 1
}

show_msn_w()
{

	echo -e "$WHITE $1 $RESET"
}

show_msn_warn()
{

	echo -e "$RED $1 $RESET"
}

report_bug() 
{

  show_msn_warn "###############_::: Error detected ::: ##############"
  show_msn_w "Please file a bug report at  $BLUE ${WEB_SITE} $RESET"
  show_msn_w "Project: $BLUE erpmtics $RESET"
  show_msn_w "Scripts: $BLUE linux/scripts/packages/wps_es.sh $RESET"
  show_msn_w "Component: $BLUE Packages $RESET"
  show_msn_w "Label: $BLUE erpmtics $RESET"
  show_msn_w "Version:  $BLUE $VERSION_SCRIPT $RESET"
  show_msn_w " "
  echo -e ""$GREEN"Please detail your operating system type, version and any other relevant details" ""$RESET""
}


check_os()
{
	ARCH=$(uname -m)

	if [ "$ARCH" == 'x86_64' ];then
		#64 bits
	    BITS="64"
	else
		#32 bits
	    BITS="32"
	fi

	if [ -f /etc/issue ]; then
		
		for distro in $DISTROS_SUPPORT
        do
            
            OS_GREP=$(grep ${distro} /etc/issue | wc -l)

           	if [ $OS_GREP -eq 1 ]; then
           		#echo "Lo mas probable es que su distro sea $distro de $BITS bits"
           		DISTRO=$distro
           	fi

        done
		#grep "Ubuntu" /etc/issue | wc -l
	else



		if DIS="$( which apt-get )" 2> /dev/null; then
		   DISTRO="Ubuntu"
		elif DIS="$( which yum )" 2> /dev/null; then
		   DISTRO="opensuse"		   
		elif DIS="$( which portage )" 2> /dev/null; then
		   DISTRO="gentoo"
		elif DIS="$( which pacman )" 2> /dev/null; then
			DISTRO="Arch"
		elif test -f "/etc/debian_version"; then
			DISTRO="Debian"
  			version=$(cat /etc/debian_version)  			  	
		else
		   exit 0
		fi
	fi
}

check_dependences()
{

	for dep in $DEPENDENCIES
        do
             if ! which $dep &>/dev/null;  then
                        DEPS_ALT="NO"
                        echo "============================================================";
                        echo "***** This script requires $dep to run but it is not installed";
                        echo "============================================================";
                        
                        #echo "Try to install dependences";
             fi

        done

}

check_package_manager()
{

	#
	check_os
	#http://en.wikipedia.org/wiki/List_of_software_package_management_systems
	show_msn_w "Please wait, try to detect your software package management system"
	#I should use https://github.com/icy/pacapt

	#If you want test distro uncomment your distro
	#DISTRO="Arch"
	#DISTRO="Ubuntu"
	#DISTRO="Debian"

	if [ "$DISTRO" == "Arch" ];then
		#PACKAGE_MANAGER="pacman -S "
		DEPENDENCIES_ARCH="lib32-fontconfig"

		if DIS="$( which packer )" 2> /dev/null; then
			PACKAGE_MANAGER="packer -S --noconfirm --noedit "
		else 
			PACKAGE_MANAGER="pacman -S --noconfirm "
		fi

		INSTALL_DEB="dpkg -i "
		PKG_WPS=$ARCH_WPS

	elif [ "$DISTRO" == "Ubuntu" ]; then
		#statements
		PACKAGE_MANAGER="apt-get install "
		INSTALL_DEB="dpkg -i "
		PKG_WPS=$UBUNTU_WPS
	
	elif [ "$DISTRO" == "Debian" ]; then
		PACKAGE_MANAGER="apt-get install "
		INSTALL_DEB="dpkg -i "

	else
		echo -e "$RED OS Unknow $RESET"
		exit 0
	fi

	show_msn_w "Detected software package management system: $BLUE $PACKAGE_MANAGER , debs with $INSTALL_DEB $RESET"
	show_msn_w "Support .deb: $BLUE $INSTALL_DEB $RESET"
	show_msn_w "Packages form software package management system: $BLUE $PKG_WPS $RESET"
 
}

install_wps_arch()
{

	show_msn_w "install package. $1"

	su -c "$PACKAGE_MANAGER $1 &> /dev/null"

	if [ ! $? -eq 0 ]; then

		show_msn_w "$1 installed"
		return 1
	else
		show_msn_w "$1 $RED no installed $RESET"
		return 0

	fi
}

install_with_package_manager()
{
	check_package_manager
	echo -e "$WHITE Please wait, exec command; $BLUE $PACKAGE_MANAGER $PKG_WPS $RESET"

	if [ "$DISTRO" == "Arch" ];then


		su -c "$PACKAGE_MANAGER $DEPENDENCIES_ARCH &> /dev/null"
		retval=$?
		#do_something $retval
		if [ $retval -ne 0 ]; then #if [ $? -eq 0 ]; then or if [ $? -ne 0 ]; then
		    #echo "Return code was not zero but $retval"

			#http://lug.mtu.edu/archlinux/multilib/os/x86_64/lib32-fontconfig-2.11.1-1-x86_64.pkg.tar.xz

			url_fontconfig="http://lug.mtu.edu/archlinux/multilib/os/x86_64/lib32-fontconfig-2.11.1-1-x86_64.pkg.tar.xz"
			name="lib32-fontconfig.pkg.tar.xz"

			if [ ! -f $name ]; then

				if wget $url_fontconfig -O "$name";then 

					if [ -f $name ]; then
						echo -e "$GREEN Download complete $RESET"

						echo "Please wait, try to install from source"

						#pacman -U /var/cache/pacman/pkg/linux-3.xx-x.pkg.tar.xz
						su -c "tar -xvpf ${name} -C / --exclude .PKGINFO --exclude .INSTALL"


					fi
				else
					  error "$LINENO: Aborting dependences: $DEPENDENCIES_ARCH not found on $DISTRO"
				fi			
			fi
		else
			return 0
		fi

		# sudo apt-get install git
		# if [ $? -gt 0 ]; then
		#     echo "ERROR!"
		# fi

	fi

	show_msn_w "Please wait -- $PACKAGE_MANAGER $PKG_WPS"
	su -c "$PACKAGE_MANAGER $PKG_WPS"

	if test $? -eq 0; then
    	show_msn_w "ERROR"
    	return 1
    	
  	fi

	#su -c "$PACKAGE_MANAGER $1"

	
}


install_with_deb()
{
	check_package_manager
	su -c "$INSTALL_DEB $1"

}

install_dependences()
{

	for dep in $DEPENDENCIES
        do
             if ! which $dep &>/dev/null;  then                        
                        show_msn_w "============================================================";
                        show_msn_w "***** Try to install $dep, please wait ..";
                        show_msn_w "============================================================";

                        install_with_package_manager

                        exit 0

                        if [ ! install_with_package_manager ]; then
                        	echo "I can install dependences, please wait"                        
                        	return 0
                        else
                        	show_msn_w "Todo bien"
                        	return 1
                        fi

             fi

        done

}

install_lang_es()
{

	show_msn_w "Plase wait, try to install lang: Spanish [Espanol]"

	show_msn_w "clone on $PATH_CLONE"

	# Check if backup folder exists if not create them
	if [ ! -d "$PATH_CLONE" ]; then
  		
  		#if [ ! -f "file" ]; then

	  		#if wget $ULR_ES -O "wps_i18n";then 
	  		#best clone repo from git
	  		show_msn_w "Cloning repo:  $BLUE $URL_GIT_REPO $RESET"

	  		if cd "${TMP_CONF}";then

		  		if git clone "${URL_GIT_REPO}";then 

					if [ -d "${PATH_CLONE}" ]; then
						echo -e "$GREEN Download complete $RESET"
					else 
						error_exit "$LINENO: Cannot clone repo Aborting."
					fi
				else
					error_exit "$LINENO: Error cloning repo Aborting."
				fi
			fi
		#fi
	fi

	#cd es || error_exit "Cannot change directory! Aborting"

	if cd $PATH_CLONE_ES 2>/dev/null; then   # "2>/dev/null" hides error message.

		#arch 
		#please link rcc

		if [ "$DISTRO" == "Arch" ];then
			#"Qt Resource Compiler" AND "arch linux"
			#https://aur.archlinux.org/packages/python2-pyside-tools/
			#sudo packer -S python2-pyside-tools qtchooser
			#ln -s rcc-gtk-config $startdir/pkg/usr/bin/rcc-config
			#export PATH=$_prefix/bin:$PATH
			#export rcc=/usr/bin/rcc-config

			#/usr/lib/qt4/bin/rcc-qt4
			#https://www.archlinux.org/packages/extra/i686/qt4/files/

			if [ -f /usr/lib/qt4/bin/rcc ];then
				show_msn_w "Version Rcc: "
				/usr/lib/qt4/bin/rcc -version

				export PATH=$PATH:/usr/lib/qt4/bin

				#-DQT_RCC_EXECUTABLE=/usr/bin/rcc-qt4
				#https://www.archlinux.org/packages/extra/x86_64/qtchooser/
				#ln -s /usr/lib/qt4/bin/rcc /usr/bin/rcc

			fi

			#unset HOME
			#export HOME=/invalid
			#qmake && make
			#sudo make install

			#find /usr/bin/rcc-config -type f -name \*.a -exec {} \;
		fi

		#exit
		
		make && make install
		# Second attempt at checking return codes
		#grep "^${1}:" /etc/passwd > /dev/null 2>&13
		if [ "$?" -ne "0" ]; then
	  		echo "Sorry, cannot find make"
	  		exit 1
		fi

	else

		error_exit "$LINENO: Cannot change directory! or not exist lang Aborting."
	fi


	if [ -d "${PATH_ES_ZIP}" ];then 
		# Create zip-file
		#zip -r "es.zip" "$filePath" 

		if cd "${PATH_ES_ZIP}";then 
			#zip -rj es.zip es/*	 
			zip -r "es.zip" "${PATH_TO_ZIP}" 

			cp es.zip $HOME

			show_msn_w "Please go to "
			show_msn_w "More info: install zip language kingsoft office"
			show_msn_w "Updating font cache... $RESET "
			su -c "fc-cache -f -v > /dev/null"

			return 0
		fi
	fi


#command && command-to-execute-on-success || command-to-execute-on-failure
}

install()
{

	#pass os
	#
	#mv mtextra.ttf /usr/share/fonts/wps-office mv symbol.ttf /usr/share/fonts/wps-office mv WEBDINGS.TTF /usr/share/fonts/wps-office mv wingding.ttf /usr/share/fonts/wps-office mv WINGDNG2.ttf /usr/share/fonts/wps-office mv WINGDNG3.ttf /usr/share/fonts/wps-office 	

	case "$1" in
  	'Arch') # Apply each step for arch linux
		
    	#command pacman-g2 -Ss "$2" | awk '$3!="[Installed:"'
    	#https://www.archlinux.org/packages/extra/x86_64/qt5-tools/
    	#https://www.archlinux.org/packages/extra/i686/qt4/
    	#pacman -S qt qtwebkit
    	#wget http://wps-community.org/download/fonts//wps_symbol_fonts.zip

    	# Not sure about syntax as gpg.conf contains two keyserver lines
		#cp -p /etc/pacman.d/gnupg/gpg.conf /etc/pacman.d/gnupg/gpg.conf.default

		#Wps instlled on /usr/share/fonts/wps-office/
  #   	install_with_package_manager 

  #   	if [ "$?" -ne "0" ]; then
  			
  # 			error "Sorry, cannot install with $PACKAGE_MANAGER"

		# fi

		#find / -type f -name libreoffice-
		# find / -iname "wpsforlinux"
		# sudo find / -iname "kingsoft-office*"
		# sudo find / -iname offi*

		#if not found wps-office try to install manual and

		# AUR_TAR="https://aur.archlinux.org/packages/wp/wpsforlinux/wpsforlinux.tar.gz"
		# name="wpsforlinux.tar.gz"

		# if [ ! -f $name ]; then

		# 		if wget $AUR_TAR -O "$name";then 

		# 			if [ -f "${name}" ]; then
		# 				echo -e "$GREEN Download complete $RESET"

		# 			fi
		# 		else
		# 			  error "$LINENO: Aborting dependences: $DEPENDENCIES_ARCH not found on $DISTRO"
		# 		fi			
		# fi


		# echo "Please wait, try to install from source"

		# #pacman -U /var/cache/pacman/pkg/linux-3.xx-x.pkg.tar.xz
		# #su -c "pacman -U $name"
		# su -c "tar -xvpf ${name} -C / --exclude .PKGINFO --exclude .INSTALL"

		# if [ $? -eq 0 ]; then
		# 	#theroy ok instll
		# 	echo -e "$WHITE Please wait, check installation $RESET"
		# fi

		#which

		if [ ! -d "${PATH_WPS}" ]; then

			echo -e "$RED WARNING: This script try to edit your pacman conf: $CONF_PACMAN $RESET"

			read -p "Do you wish continue? [Yes (y) / No (n)]" choice
				case "$choice" in 
					y|Y ) 
												
						#edit pacman conf
						#back up CONF_PACMAN

						#
						if [ ! -d "${TMP_CONF}" ]; then

							if mkdir "${TMP_CONF}";then

								exit 1
							fi
						fi

						if [ -d "${TMP_CONF}" ]; then

							#echo -e "$WHITE $RESET"
							show_msn_w "plase wait ..."

							if cd "${TMP_CONF}";then

										#echo "$TMP_CONF$CONF_PACMAN.old"										

										if  cp $CONF_PACMAN $B_CONF_PACMAN; then
										#if  cp -i $CONF_PACMAN $TMP_CONFpacman.conf.old; then

											#exit 1

											show_msn_w "Try to backup your conf"


										fi

										if [ ! -f "${B_CONF_PACMAN}" ]; then

											error_exit "I can't continue error fatal"

										fi

										show_msn_w "Copy $B_CONF_PACMAN to $B_CONF_PACMAN.2"

										if cp $B_CONF_PACMAN $B_CONF_PACMAN.2; then

											echo "....."

										else 
											exit 0

										fi


										LINE1="\#\[multilib\]"
										LINE2="\[multilib\]"
										LINE3="#Include = /etc/pacman.d/mirrorlist"

										#sed 's/[:space:]+/,/g' orig.txt > modified.txt
										LINE4="Include[:space:]\=\/etc\/pacman.d\/mirrorlist"
										#sed -e "s/\s\{3,\}/  /g" 
										#LINE4="Include \= \/etc\/pacman\.d\/mirrorlist"


								        LINEINIT=$( cat $B_CONF_PACMAN.2 \
								        | grep -n "${LINE1}" \
                                		| grep '[0-9]\{2\}:\#' | cut -d ":" -f 1 ) #awk '{print $1,"\n"}' )  #awk -F ' ' '{print $1}' ) # | s$										
										
										
										C=1																											
										X=$(( $LINEINIT+$C ))

										#sed '575s/CODE = 1234/CODE = 5678/'
										#MUL=$( sed -i 's/'$LINE1'/'$LINE2'/g' $B_CONF_PACMAN.2 ) #This remplace on file #[multilib] for [multilib] 
																								 #Include = /etc/pacman.d/mirrorlist for Include = /etc/pacman.d/mirrorlist
							
										#MUL=$( sed -n -e ${LINEINIT},${X}p $B_CONF_PACMAN.2 | sed 's/\#//g')	
										#-i is inline
										#-i.bak (No space) will make a .bak

										#sed -i.bak -e 's/findthis/changetothis/' /home/yourdir/yourtestfile

										#if [ "$a" -gt "$b" ]
										if [ $? -ne 0 ]; then
										#if [ "${LINEINIT}" -gt "0" ];then

											show_msn_w "Edit Line: $LINEINIT to $X"									

											MUL=$( sed -n -e ${LINEINIT},${X}p $B_CONF_PACMAN.2 | sed 's/\#//g' ) #> $B_CONF_PACMAN.3)

											show_msn_w "mmmmmmmmm ------ $BLUE $MUL $RESET"
											if [ $? -ne 0 ]; then
												show_msn_warn "No changes on Pacman conf"										    
											else
										        	echo "${MUL}"
										        	show_msn_w "${LINEINIT}s/.*/${LINE2}/"
										        	#example
										        	#sed '93s/.*/[multilib]/' /home/armando/.erpmtics/pacman.conf.old >  /home/armando/.erpmtics/pacman.conf.old.4
										        	#OK=$( sed '${LINEINIT}s/.*/${LINE2}/' $B_CONF_PACMAN.2 >  $B_CONF_PACMAN.5 )

										        	#sed -e 's/\'//g -e 's/,/ /g' -e 's/[ \t]\+/ /g' test.txt

										        	OK=$( sed ${LINEINIT}s/.*/${LINE2}/ $B_CONF_PACMAN.2 >  $B_CONF_PACMAN.5 )
										        	if [ ! $? -ne 0 ]; then
														#sed '${X}s/.*/${LINE4}/' $B_CONF_PACMAN.2 > $B_CONF_PACMAN.5
														show_msn_w "ok"

														#Replace # (delete)
														OK2=$( sed ${X}s/\#//g $B_CONF_PACMAN.5  >  $B_CONF_PACMAN.6 )

														if [ ! $? -ne 0 ]; then
														 	show_msn_w "ok 2"

														 	ORG_NO=$(cat "$CONF_PACMAN" | wc -l ) #Num lines
															EDIT_NO=$(cat "$B_CONF_PACMAN.6" | wc -l ) #Num lines														

															if [ "${ORG_NO}" -eq "${EDIT_NO}"  ]; then
																
																show_msn_w "Please wait, remplace conf pacman"

																CONF_PACMAN_NEW="$TMP_CONF/pacman.conf"
																#to $CONF_PACMAN

																if mv $B_CONF_PACMAN.6 $CONF_PACMAN_NEW; then 																

																	show_msn_w "Todo bien"

																	cat "$CONF_PACMAN_NEW"

																	su -c "cp $CONF_PACMAN_NEW $CONF_PACMAN"

																	if [ ! $? -ne 0 ]; then
																		show_msn_w "Update pacman db"
																		#https://bbs.archlinux.org/viewtopic.php?id=116373
																		#http://community.wps.cn/wiki/index.php/Arch_%E4%BA%8C%E8%BF%9B%E5%88%B6%E5%8C%85%E5%88%B6%E4%BD%9C%E6%AD%A5%E9%AA%A4
																		show_msn_w "Read more: https://wiki.archlinux.org/index.php/multilib"
																		su -c "pacman -Syu"

																	fi
																	# if su -c "mv $CONF_PACMAN_NEW $CONF_PACMAN";then 
																	
																		
																	# fi
																fi
																
															fi

														# 	exit 1
														fi
														
										        	fi

										        	


											fi										
                                        
                                        else                                        	
                                        	show_msn_w "Update pacman db"
											su -c "pacman -Syu"
										fi
                                        #diff $B_CONF_PACMAN.2 $B_CONF_PACMAN.3

                                        #sed -i.bak s/STRING_TO_REPLACE/STRING_TO_REPLACE_IT/g index.html
                                        #sed 's/\#//g' $B_CONF_PACMAN.2 > $B_CONF_PACMAN.tmp
										#mv $B_CONF_PACMAN.tmp $B_CONF_PACMAN.2                                       

										#echo "92:#" | grep '[0-9]\{2\}:\#' | cut -d ":" -f 1

										#cat /home/armando/.erpmtics/pacman.conf.old.2  | grep -n "\#\[multilib\]" | grep '[0-9]\{3\}-[0-9]\{4\}'
										#install_wps_arch wps-office

										#https://aur.archlinux.org/packages/wpsforlinux/
										#http://kdl.cc.ksosoft.com/wps-community/kingsoft-office_9.1.0.4280~a12p4_i386.deb
										#
										#
										#

										# https://aur.archlinux.org/packages/kingsoft-office/
										# https://aur.archlinux.org/packages/ki/kingsoft-office/PKGBUILD
										#dependences
										#ubuntu --libqt4-dev
										#https://www.archlinux.org/packages/extra/x86_64/libcups/
										#https://www.archlinux.org/packages/community/x86_64/librcc/files/

										# - Don't forget to install gtk or/and gtk2 packages to enable librcc
										#    gui features
										# -- Also you may change /usr/bin/rcc-config symlink to switch between
										#    gtk and gtk2 (rcc-gtk-config and rcc-gtk2-config)

										#pacman -Si librcc | grep Depends
										install_wps_arch libcups librcc taglib-rcc gtk2
										install_wps_arch kingsoft-office 

										#Bugs rcc + qt4
										# https://bugs.archlinux.org/task/5974
										# https://bugs.archlinux.org/task/6057
										# https://bugs.archlinux.org/task/34402?opened=8101&status%5B0%5D=



										#Try run 
										if [ -d /opt/kingsoft/ ];then
										
											/opt/kingsoft/wps-office/office6/wps

											ps auxw | grep wps | grep -v grep > /dev/null

											if [ $? != 0 ];then
												show_msn_w "Operation completed ..."																						    
											fi									

										else

											#Try to install 
											# https://aur.archlinux.org/packages/kingsoft-office/
											# https://aur.archlinux.org/packages/ki/kingsoft-office/PKGBUILD
											#sudo pacman -R wpsoffice-fonts
											install_wps_arch wpsforlinux

											#Try run 
											if [ -d /opt/kingsoft/ ];then
											
												/opt/kingsoft/wps-office/office6/wps

												ps auxw | grep wps | grep -v grep > /dev/null

												if [ $? != 0 ];then
													show_msn_w "Operation completed ..."																						    
												fi									

											else
													#sudo find / -iname 'kingsoft-office*' | grep "\.deb"
													DEBS=$( su -c "find / -iname 'kingsoft-office*'" | grep "\.deb" )													

													for deb in $DEBS
												        do
												            #if ! which $deb &>/dev/null;  then
												                show_msn_w "============================================================";
												                show_msn_w "***** Try to install: $BLUE $deb form deb $RESET";
												                show_msn_w "============================================================";
												                        
												             	install_with_deb $deb

												             	if [ $? != 0 ];then
												             		show_msn_w "Operation completed ..."
												             	fi
												            #fi

												        done
											fi


											#report_bug

											#show_msn_warn "Definitely I can not install the package"
											#https://www.archlinux.org/packages/extra/i686/qt4/files/
											ready=1

											pacman -Q qt4

											if [ $? != 0 ];then
												ready=0
											fi

											packer -Ss qt4

											if [ $? != 0 ];then
												ready=0
											fi


											if [ "${ready}" -eq 0 ];then

												show_msn_w "Prepare to install es"

												# dpkg cmake qt4 qtwebkit git												



											elif [ "${ready}" -eq 1 ];then

												report_bug

												show_msn_warn "Definitely I can not install the package"

											fi



										fi


							fi
						fi

						echo -e "$GREEEN Complete install $RESET"
					;;
						n|N ) exit 0
										
					;;
					* ) report_bug
						#echo "$RED invalid or you dont' have a tty or you are test the script on your source code editor $RESET";
				esac
				
				#CONF_PACMAN

		fi

		#open with wpsoffice

    	#install_lang_es
  	;;
  	'Ubuntu') # Apply each step for Ubuntu
    	#command pacman-g2 -Ss "$2" | awk -vq="$2" '$2~q'
    	echo "Ubuntu ----"

    	#Wps instlled on /opt/kingsoft/wps-office/

    	#sudo apt-get install qt4-dev-tools
    	#libqt4-dev
    	su -c "apt-get install qt4-dev-tools msttcorefonts gsfonts-x11"

  #   	if apt-get -qq install $pkg; then
		#     echo "Successfully installed $pkg"
		# else
		#     echo "Error installing $pkg"
		# fi

		#check libs 
		which rcc
		which lrelease-qt4

		# Check that target file wps.deb exists
		if [ ! -f $PATH_DEB ]; then
	        echo -e "$WHITE Please wait, try download wps... $RESET"
	        sleep 1
	        #http://kdl.cc.ksosoft.com/wps-community/kingsoft-office_9.1.0.4280~a12p4_i386.deb
			if wget $WPS_DEB -O "${DEB}";then 
				#seach file
				# if [ test $? -eq 0 ];then
			 #  		echo "No command-line arguments."
				# else
			 #  		echo "First command-line argument is $1."
				# fi

				if [ -f $DEB ]; then
					echo -e "$GREEN Download complete $RESET"
				else 
					exit 0
				fi
			fi
		fi

		echo -e "$WHITE Plase wait, try to install Package $RESET"
		

		install_with_deb $PATH_DEB
		install_with_package_manager 


  	;;
 	*)

		error_exit "$LINENO: Could not detect supported Linux distribution. Supported operating systems: $DISTROS_SUPPORT"
    	
  	;;
	esac

	# if [ -f wps_symbol_fonts.zip ]; then

	# 	if [ -d /usr/share/fonts/wps-office]; then
	# 		mv mtextra.ttf /usr/share/fonts/wps-office mv symbol.ttf /usr/share/fonts/wps-office mv WEBDINGS.TTF /usr/share/fonts/wps-office mv wingding.ttf /usr/share/fonts/wps-office mv WINGDNG2.ttf /usr/share/fonts/wps-office mv WINGDNG3.ttf /usr/share/fonts/wps-office 	
	# 	fi
	# fi
	#echo -e "$WHITE Updating font cache... $RESET "
	#su -c "fc-cache -f -v > /dev/null"

}



unistall()
{
	#sudo dpkg -r wps-office
	su -c "dpkg -r wps-office"
}

#first check depen
check_os
#then ckeck dependences for this distro
check_dependences

#install_lang_es

#Testing all dependences 
show_msn_w "============================================================";
show_msn_w "\n Please wait, checking dependences .. \n"
show_msn_w "============================================================";


if [ "$DEPS_ALT" == "NO" ]; then

	echo -e "$RED The operative system missing dependencies for the following libraries ... $RESET"

	read -p "Do you wish to install dependences? [Yes (y) / No (n)]" choice
	case "$choice" in 
	  y|Y ) echo "yes"
			if install_dependences; then
				echo "complete install"
			else
				show_msn_w "I can't install dependences"
			fi
			;;
	  n|N ) exit 0
		
		;;
	  * ) echo "$RED invalid or you dont' have a tty or you are test the script on your source code editor $RESET";
	esac
fi

#check if exist wps (Kingsoft office)
if ! which wps &>/dev/null;  then
	show_msn_w "============================================================";
	show_msn_w "**This script requires WPS (Kingsoft Office) to run but it is not installed";
	show_msn_w "============================================================";

	#try to install
	install $DISTRO
	#install_with_package_manager 
	
fi

install_lang_es

exit 0

# cd /opt/kingsoft/wps-office/office6/2052
# sudo rm qt.qm wps.qm wpp.qm et.qm

# wget -a http://wdl.cache.ijinshan.com/wps/download/Linux/unstable/wps-office_8.1.0.3724~b1p2_i386.deb
# sudo dpkg -i wps-office_8.1.0.3724~b1p2_i386.deb

# curl -O https://raw.githubusercontent.com/erpmtics/erpmtics/testing/tools/build/make-linux.sh
# /bin/bash make-linux.sh

# su -c " yum -y install wget && wget -P/etc/yum.repos.d/ https://raw.github.com/kuboosoft/postinstallerf/master/postinstallerf.repo && yum -y install wps-i18n-es "
