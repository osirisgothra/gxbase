#!/bin/bash                                               
#
# installerstub.sh
#   
#   Stubfile used by the installer (not directly)
#
#   *** IN DEVELOPMENT (pre-alpha still) NOT USED YET (I need a manager) ***
# 
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
# 
# Copyright (C)2013 Paradisim Enterprises, LLC 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This file was created: Dec 7 2013 			Last Update: Feb 22 2014
#
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#
# DO NOT CHANGE THIS FILE IT WILL BREAK THE INSTALLER -- MAKE SURE THE FOLLOWING LINES ARE ACCURATE
# AND LEAVE ALL COMMENTS WHERE THEY ARE!!!!!!!
#
if (false); then
# Between the stub markers are the contents that will be written to the
# setup, minus the notion of the 'install prefix' which defaults to /usr/local
# once the installer is written, it will be able to transpose the prefix to the
# appropriate values in all the scripts when installing the files into the target
# user's filesystem. Extensive testing of this will be needed but is not part of 
# the main development at this time. see the top-level documentation for more info
# **this file is still subject to change/removal unless under management which it's not**
#GX_STUB_START
	# start GXBASE (The GNU Extended Bourne-Again Shell Environment) ** automatically added by Installer, don't modify! **                                                             # used to start GxBase
 	[[ -r /usr/local/lib/gxbase ]] && . /usr/local/gxbase/gxbase -nf $BASH_SOURCE || echo "GXBASE not found, check your settings to ensure they are correct or try to install again."  # used to start gxbase
#GX_STUB_END
else
	if [[ -d $GXBASE_ROOT ]]; then
		echo "GXBASE variable is already installed, use the installer to reinstall it."
	else    
		if [[ -z $GXBASE_DISABLE_WARNING ]] || [[ $1 == GXBASE_DISABLE_WARNING ]]; then
			echo "This script is not intended to be run directly as it is used by the installer."
			echo "Nothing successfully accomplished with infinite grandeur..."
		else
      echo "Installing stub into startup file..."
			if [[ -w ~/.profile ]]; then
				echo "Using .profile"
			elif [[ -w ~/.logon ]]; then
				echo "Using .logon"
			elif [[ -w ~/.bashrc ]]; then
				echo "Using .bashrc"
			else
				echo "No startup script could be determined, do you want to make one?"
      fi
		fi
fi
