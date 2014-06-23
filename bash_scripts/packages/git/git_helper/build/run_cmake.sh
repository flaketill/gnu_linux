#!/usr/bin/env sh
# -*- coding: UTF-8 -*- 
# Copyright (C) 2014 Armando Ibarra
#  v0.1 alpha - 2014
# 

#***************************************************************************#
# Helper git for beginner
#
# Author: Ing. Armando Ibarra - armandoibarra1@gmail.com
# Email: armandoibarra1@gmail.com
# Date: 19/06/2014 
# Purpose:
#    Help to cmake on linux OS
#
#----------------------------------------------------------------------
# NOTES:    
#----------------------------------------------------------------------
#	 No for advanced users 
#    Test on Archlinux
#
#
#***************************************************************************#

###############################################################################

# ***** BEGIN GPL LICENSE BLOCK *****

# Licensed under the GNU GPL v3 - http://www.gnu.org/licenses/gpl-3.0.txt
# - or any later version.

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

# ***** END GPL LICENSE BLOCK *****

###############################################################################

#variables

#autor and project data
AUTHOR='Ing. Armando Ibarra <armandoibarra1@gmail.com>'
COPYRIGHT='Copyright (c) 2014, armandoibarra1@gmail.com'
LICENSE='GNU GPL Version 3'

BUGS="https://github.com/flaketill/gnu_linux/issues"
VERSION_SCRIPT="0.0.1 alpha"

THIS_SCRIPT_PATH=`readlink -f $0`
THIS_SCRIPT_DIR=`dirname ${THIS_SCRIPT_PATH}`

#Dirs cmake
PATH_CMAKE_FILES=$THIS_SCRIPT_DIR"/CMakeFiles/"
PATH_CMAKE_TESTING=$THIS_SCRIPT_DIR"/Testing/"

#Files
PATH_CMAKE_LIST=$THIS_SCRIPT_DIR"/CMakeLists.txt"

#Files delete
PATH_CMAKE_CACHE=$THIS_SCRIPT_DIR"/CMakeCache.txt"
PATH_CMAKE_INSTALL=$THIS_SCRIPT_DIR"/cmake_install.cmake"
PATH_CMAKE_MAKEFILE=$THIS_SCRIPT_DIR"/Makefile"

FILES_TO_DELETE="${PATH_CMAKE_CACHE} ${PATH_CMAKE_INSTALL} ${PATH_CMAKE_MAKEFILE}"
DIRS_TO_DELETE="${PATH_CMAKE_FILES} ${PATH_CMAKE_TESTING}"
#colors bash script
GREEN="\033[1;32m"
RESET="\033[0m"
WHITE="\033[1;37m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"

USE_GUI=1

show_msn_w()
{

	echo -e "$WHITE $1 $RESET"
}

show_msn_green()
{

	echo -e "$GREEN $1 $RESET"
}

show_msn_blue()
{

	echo -e "$BLUE $1 $RESET"
}

show_msn_yellow()
{

	echo -e "$YELLOW $1 $RESET"
}

show_msn_warn()
{

	echo -e "$RED $1 $RESET"
}

show_msn_info()
{

	echo -e "$YELLOW $1 $RESET"
}

report_bug() 
{

  #sleep 3

  show_msn_warn "###############_::: Error detected ::: ##############"
  show_msn_w "Please file a bug report at  $BLUE ${BUGS} $RESET"
  show_msn_w "Project: $BLUE erpmtics $RESET"
  show_msn_w "Scripts: $BLUE gnu_linux/scripts/packages/git/git_helper.sh $RESET"
  show_msn_w "Component: $BLUE Packages $RESET"
  show_msn_w "Label: $BLUE erpmtics $RESET"
  show_msn_w "Version:  $BLUE $VERSION_SCRIPT $RESET"
  show_msn_w "Some detail detected on you Operating System:"
  show_msn_yellow "***********************"
  echo -e "$WHITE BASH:$RESET $BLUE $BASH_VERSION $RESET"
  echo -e "$WHITE Operating system:$RESET $BLUE $OSTYPE $RESET"
  echo -e "$WHITE OS type:$RESET $BLUE $HOSTTYPE $RESET"
  echo -e "$WHITE This script has been running $RESET $BLUE $SECONDS $RESET"
  show_msn_yellow "***********************"
  echo -e "$WHITE Please detail your operating system for example"
  echo -e "$GREEN if you use GNU/Linux what distribution (Arch Linux, Ubuntu, Debian) $RESET"
  echo -e "$GREEN if you use Mac OS X version (Leopard , Lion) $RESET"
  echo -e "$GREEN Finally plese send more detail like type, version and any other relevant details $RESET"
}

print_usage()
{
  cat <<END
Usage:

	Main program: $0      
	
	Other functions: $0 + argument

	Arguments
			 	-h, --help     This message
				-v, --version  Output version information and exit			

	Example use on Linux or Mac OS X (If you open a terminal eg: [$USER@$HOSTNAME build]$ )
	Then use like this

	How to:

		* Show version:

			[$USER@$HOSTNAME build]$ $0 -v
			or $0 --version

		* Show this (help):

			[$USER@$HOSTNAME build]$ $0 -h
			or $0 --help		
END
}

usage_error ()
{
  show_msn_w "Error:"
  show_msn_w " runing $YELLOW sh $0 $1 $RESET $RED ---> INVALID ARGUMENT $RESET" 
  show_msn_w "You are using like this" 
  show_msn_warn "[$USER@$HOSTNAME build]$ sh $0 $RESET 4 " >&2
  echo -e " "
  show_msn_green "$USER you should use like this:"
  show_msn_warn "[$USER@$HOSTNAME build]$ sh $0 " >&2

  show_msn_blue "Or for more option:"
  echo -e " "
  show_msn_w "###################### This is Help ##################"
  print_usage >&2
  show_msn_w "######################Help##################"
  #exit 2
}

############################################################
# Version function - Displays with colors ob shell         #
############################################################
print_version()
{
	echo -e "$GREEN $0 $WHITE version $RESET $BLUE  $VERSION_SCRIPT $RESET" 
	exit 0
}

use_gui()
{
	DIALOG=$(which dialog 2> /dev/null)
	
	if [  $? -eq 0 ];then
		USE_GUI=0
	fi

}

print_version_dialog()
{

	$DIALOG --backtitle "$TITLE" --colors --title "About git_helper" \
		--cancel-label "Quit" --menu "" 9 50 3 "1" "Version $VERSION_SCRIPT" "4" "Return to main menu" 2>"$TMP"

	read DV <"$TMP"
	rm -f "$TMP"
	if [ "$DV" = "4" ]; then
		main
	else
		clear
		exit
	fi

}

delete_files()
{

for FILE in "${FILES_TO_DELETE}"; do

	#printf  "\nDelete file: ${FILE}"
	#echo -e "\nDelete file: ${FILE}\n----"
	
	if [ -f "${FILE}" ];then
		show_msn_w "Delete file:" show_msn_info "${FILE}"
		rm "${FILE}"
	else
		show_msn_info "Skip: No exist file: ${FILE}"
	fi

done

}

delete_dirs()
{

for DIR in "${DIRS_TO_DELETE}"; do
	#statements
	
	if [ -d "${DIR}" ];then
		show_msn_w "Delete dir: ${DIR}"
		rm -R "${DIR}"
	else
		show_msn_info "Skip: No exist dir: ${DIR}"
	fi

done

}


options_map()
{

	case $1 in
	  --help) print_usage; exit $?;;
	  --version) echo "$0 $VERSION_SCRIPT"; exit $?;;
	  --) shift; break;;
	  -*) usage_error "invalid option: '$1'";;
	esac
	shift

}

############################################################
# Run function dialog                      				   #
############################################################

run_cmake() 
{
	clear
	show_msn_w "Runing cmake ..."
	delete_files
	delete_dirs
	cmake $PATH_CMAKE_LIST
}

############################################################
# Main function 			                               #
############################################################
main()
{
	TITLE="Make file with cmake"
	TMP="/tmp/git_helper_cmake"

	#dialog, xterm
	show_msn_w "Please wit init "

	use_gui

	if [  "${USE_GUI}" -eq 0 ];then   

		$DIALOG --backtitle "$TITLE" --colors --title "cmake for git_helper:: Main menu" \
		--cancel-label "Quit" --menu "" 9 50 3 "1" "Run" "2" "Show info" 2>"$TMP"

		read DV <"$TMP"
		rm -f "$TMP"
		if [ "$DV" = "1" ]; then
			run_cmake
		elif [ "$DV" = "2" ]; then
			print_version_dialog
		else
			clear
			exit
		fi

	#     #exit 1
	else
		show_msn_w "Error: i can't make directory "
	fi

	#cmake $PATH_CMAKE_LIST
	#sudo make install

}

#----------------------------------------------------------------------
# Call a main function
#----------------------------------------------------------------------

############################################################
# Check arguments passed at runtime                        #
############################################################
case "$1" in
	'-w'|'--welcome')
		main
	;;
	'-h'|'--help')
		print_usage
	;;
	'-v'|'--version')
		print_version
	;;
	'')
		main
	;;
	*)
		usage_error "invalid option: '$1'"	
		echo -e " "
		echo -e " "
		report_bug	
	;;
esac

# if [[ "$BASH_SOURCE" == "$0" ]]; then
#     main
# else
# 	options_map $1
# 	test $# -gt 0 || usage_error
# fi

# make
# ctest -R Python
# sudo make install