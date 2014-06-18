#!/usr/bin/env sh
# -*- coding: UTF-8 -*- 
# Copyright (C) 2014 Armando Ibarra
#  v0.1 alpha - 2014
# 

#----------------------------------------------------------------------
# ubuntu install git
#
# Author: Ing. Armando Ibarra - armandoibarra1@gmail.com
# Email: armandoibarra1@gmail.com
# Date: 13/06/2014 
# Purpose:
#    Performs the install git on GNU/Linux Ubuntu Distro
#    this shell script try to install depencences 
#    on linux OS, invokes some system commands like
#    sudo, apt-get install, etc
#
#----------------------------------------------------------------------
# NOTES:    
#----------------------------------------------------------------------
#    Test on ubuntu 13.04
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

__author__ = 'Ing. Armando Ibarra <armandoibarra1@gmail.com>'
__copyright__ = 'Copyright (c) 2014, armandoibarra1@gmail.com'
__license__ = 'GNU LGPL Version 2.1'

URL_GIT_REPO="https://github.com/flaketill/gnu_linux"

setup_git()
{
	git config --global user.email "armandoibarra1@gmail.com"
	git config --global user.name "Ing. Armando Ibarra"
	git remote add origin ${URL_GIT_REPO}

}

push_git()
{
	git push -u origin master
}

install_git()
{
	sudo apt-get install git
}

main()
{
	install_git
	setup_git
}

main


#