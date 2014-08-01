#!/bin/bash
#
# 000-makeblur.sh
#   
#   applies the blur effect to the background of the terminal, if available (KDE)
# 
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
# 
# Copyright (C)2011-2014 Paradisim Enterprises, LLC 
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
# This file was created 
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#
# Created Nov 7 2013
# Updated Feb 23 2014
# 
#

# FIX:1 fully integrated the blur effect script into this script, no external program is needed
#       anymore.
#     2 added check for linux terminal and missing display variable
#     3 added header and incremented copyright info

echo -ne "$(abscol 33)kwin terminal compositing"
if [[ $DISPLAY ]]; then
	echo -ne " DISPLAY=[$DISPLAY] "
	if ( ! xprop -root | grep KDE > /dev/null ); then
		echo "(disabled, not KDE window)"; false
	else
		function gx.xprop.getcurrentwindow()
		{
			if (tty -s); then
				getspec="-root"
			else
				getspec=
			fi
			xprop $getspec | grep ^"_NET_ACTIVE_WINDOW" | grep --only-matching "0x[0-9a-fA-F]*" --color=never			
		}		
		xprop  -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id `gx.xprop.getcurrentwindow`
		RETVAL=$?	 
		if [ $RETVAL -ne 0 ]; then
			if [ $RETVAL -eq 1 ]; then
				echo "(set attempted, but failed)"
			else
				echo "(set attempted, unknown result code=$RETVAL)"
			fi						
		else
			echo "(attempt made/suceeded)"
		fi
	fi
elif [[ $TERM == linux ]]; then
	echo "(low text-only terminal)"
else
	echo "(no access to a DISPLAY)"
fi
