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
# Date: 18/06/2014 
# Purpose:
#    Help git on linux OS
#
#----------------------------------------------------------------------
# NOTES:    
#----------------------------------------------------------------------
#	 No for advanced users 
#    Test on Archlinux
#    I use "Scripting with style bash script "
#         * https://google-styleguide.googlecode.com/svn/trunk/shell.xml
#         * http://wiki.bash-hackers.org/scripting/style
#         * http://www.tldp.org/LDP/abs/html/
#
#
#***************************************************************************#

###############################################################################

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

###############################################################################

#variables

#autor and project data
AUTHOR='Ing. Armando Ibarra <armandoibarra1@gmail.com>'
COPYRIGHT='Copyright (c) 2014, armandoibarra1@gmail.com'
LICENSE='GNU GPL Version 3'

WEB_SITE="https://github.com/flaketill"
BUGS="https://github.com/flaketill/gnu_linux/issues"
VERSION_SCRIPT="0.0.1 alpha"

#colors bash script
GREEN="\033[1;32m"
RESET="\033[0m"
WHITE="\033[1;37m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"

ANSWER=""

#Licence
URL_GLPV3_GIT="https://raw.githubusercontent.com/flaketill/gnu_linux/master/LICENSE"
URL_GLPV3="http://www.gnu.org/licenses/gpl.txt"

FILES_INIT="README.md LICENSE .gitignore"
DISTROS_SUPPORT="Arch Ubuntu Debian"

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

#errorcode MAP
E_BADDIR=85  # No such directory.

LOGFILE=/var/log/messages  # Only line that needs to be changed.

#${LINENO}${FUNCNAME[0]:+ ${FUNCNAME[0]}}|

#DEBUG 
debug_info()
{
	echo -e "$WHITE DEBUG::INFO ${LINENO}${FUNCNAME[0]:+ ${FUNCNAME[0]}} -- $RED $1 $RESET"
}

#-------------------------------------------------------------------------------
# Echo messages on shell color white
#-------------------------------------------------------------------------------
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
  show_msn_w "Please file a bug report at  $BLUE ${BUGS} $RESET"
  show_msn_w "Project: $BLUE erpmtics $RESET"
  show_msn_w "Scripts: $BLUE gnu_linux/scripts/packages/git/git_helper.sh $RESET"
  show_msn_w "Component: $BLUE Packages $RESET"
  show_msn_w "Label: $BLUE erpmtics $RESET"
  show_msn_w "Version:  $BLUE $VERSION_SCRIPT $RESET"
  show_msn_w " "
  echo -e ""$GREEN"Please detail your operating system type, version and any other relevant details" ""$RESET""
}

ask()                         
{                                    
  prompt=$1                          
  echo -n $prompt
  read answer
  ANSWER=$answer
  #choice=$?
  #read -p "Do you wish to install dependences? [Yes (y) / No (n)]" choice
}  

#chmod u+x 
#var="$(bash --version "$(command1)")"

#-------------------------------------------------------------------------------
# Cleanup temporary file in case of keyboard interrupt or termination signal.
#-------------------------------------------------------------------------------
cleanup_temp() 
{
	#[ -e $tmpfile ] && rm --force $tmpfile
	show_msn_w "Error, Please wait cleanup .."
	exit 0
}

trap cleanup_temp SIGHUP SIGINT SIGPIPE SIGTERM


#Steps new repo
#git init 
#git add .
#git commit -m "Bash scripts for ..."
#git remote add origin git@github.com:flaketill/macosx.git
#git push -u origin master

build_readme()
{
	show_msn_w "build README.md file $1"

: <<'END'
# $1

## Overview

Description:

Repositiry for shell or python scripts under Mac OS X,
for example bash script for install on Mac firefox

##Technologys

* Python >= 2.7
* Bash >= 4.3.18

## LICENSE
$2

License: Licensed under the GNU GPL v3

##Contact

Facebook: https://www.facebook.com/
Twitter: https://twitter.com/

For details on authorship, see AUTHORS
END

}

build_license()
{
	show_msn_w "build LICENSE file $1"
	#wget -O $1 $URL_GLPV3
	#wget $URL_GLPV3
	#curl -Lo %s %s

	#curl $URL_GLPV3 > $1
	#curl -O $URL_GLPV3 > $1
	#curl -o savedpage.html $URL_GLPV3
	#curl -o savedpage.html $URL_GLPV3 #>> $HOME"/test/LICENSE"
	#wget $URL_GLPV3 --output-document "${1}"

	curl -o LICENSE "$URL_GLPV3"

	if [ -f LICENSE ];then	
		#curl "$URL_GLPV3" > $1

		show_msn_w "Moved LICENSE"
		if [ -f "$1" ];then
			if mv LICENSE "$1"; then
				return 0
			fi 
		fi
	fi


# -----------------------------------------------------------
# 'Here document containing the body of the generated LICENSE
(
cat <<-ENDOFMESSAGE

ENDOFMESSAGE
) > $1
# -----------------------------------------------------------

#wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL_GLPV3
#wget -O $1/list.txt http://url.to/list_pkg.txt
#wget -P /shared http://...

LICENSE_TXT=$(cat <<SETVAR
GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The GNU General Public License is a free, copyleft license for
software and other kinds of works.

SETVAR
)

#echo "$LICENSE_TXT"

#curl -H 'Authorization: token INSERTACCESSTOKENHERE' -H 'Accept: application/vnd.github.v3.raw' -O -L URL_GLPV3


}

build_files_init()
{

	for file in $FILES_INIT; do
		#statements
	
		if [ ! -f "$1/${file}" ];then
			echo -e "Please wit, build file: ${file} on $1"
			touch "$1/${file}"
			#touch "${file}"
			#touch file1 file2 file3
		else
			show_msn_warn "$1/${file} already exist$1/${file}"
		fi

		#
		if [ -f "$1/${file}" ];then
			# Make the generated file executable.
			chmod 775 "$1/${file}"

			if [ "${file}" == "README.md" ];then

				build_readme "$1/${file}"

			elif [ "${file}" == "LICENSE" ]; then
				#statements
				build_license "$1/${file}"
			fi
		fi

	done

}

#=== FUNCTION ================================================================
# NAME: build_repository
# DESCRIPTION: Create a new repository on the command line
# PARAMETER 1: $target_directory 
# RETURNS: 0 on success, $E_BADDIR if something went wrong.
# Usage: build_repository /home/$USER/scrips 
#=============================================================================

build_repository()
{

	if [ ! -d $1 ];then # Test if target directory exists.

		mkdir "$1" 2> /dev/null

		if [ $? -ne 0 ];then
			show_msn_w "Error: i can't make directory "
		fi

	else
		#${LINENO}${FUNCNAME[0]:+ ${FUNCNAME[0]}}|
		debug_info "The dir for repo exist"

		ask "Do you wish continue? [Yes (y) / No (n)]"
		
		case "$ANSWER" in 
		  y|Y ) echo "yes"
				show_msn_w "Init repo on $1"

				build_files_init $1

				echo "complete install"
				;;
		  n|N ) exit 0
			
			;;
		  * ) show_msn_w "$RED invalid or you dont' have a tty or you are test the script on your source code editor $RESET";
		esac
		#echo $favorite_number

		#return $E_BADDIR

	fi

	return 0   # Success.

}

#( <command> 2>&1 | tee compile.log && exit $PIPESTATUS )

if [ -f "$LOGFILE" ];then
  	show_msn_w "ok"
fi

main()
{

build_repository $HOME/test

}
#----------------------------------------------------------------------
# Call a main function
#----------------------------------------------------------------------


if [[ "$BASH_SOURCE" == "$0" ]]
then
    main
fi


#Self-documenting script

DOC_REQUEST=70

if [ "$1" = "-h"  -o "$1" = "--help" ]     # Request help.
then
  echo; echo "Usage: $0 [directory-name-target]"; echo
  sed --silent -e '/DOCUMENTATIONXX$/,/^DOCUMENTATIONXX$/p' "$0" |
  sed -e '/DOCUMENTATIONXX$/d'; exit $DOC_REQUEST; fi

: <<DOCUMENTATIONXX
Bash Script for git
---------------------------------------------------------------

You can build a new repository fast and easy with $0

DOCUMENTATIONXX

exit 0

if [ -z "$1" -o ! -r "$1" ]
then
  directory=.
else
  directory="$1"
fi  

echo "Listing of "$directory":"; echo
(printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH DAY HH:MM PROG-NAME\n" \
; ls -l "$directory" | sed 1d) | column -t



#Press <Ctrl-c> to quit


git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:flaketill/macosx.git
git push -u origin master

#Push an existing repository from the command line

git remote add origin git@github.com:flaketill/macosx.git
git push -u origin master