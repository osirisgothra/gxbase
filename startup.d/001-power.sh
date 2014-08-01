#!/bin/bash
#
# 001-power.sh
#   
#   Power Related Startup Functions
# 
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
# 
# Copyright (C)2014 Paradisim Enterprises, LLC 
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
echo -ne "$(abscol 33)power related actions: "

# state will be assumed to be on AC POWER if power state cannot be determined
# since there has been no reports of on_ac_power NOT working for laptops
# of course, you can override this with the GX_ASSUME_BATTERY flag!

if [[ -x /usr/bin/on_ac_power ]]; then on_ac_power
 	case $? in
 	 	255) ;& 0) BATTERY=false;;
		1) BATTERY=true;;
		*) BATTERY=unknown;;
	esac
else
	BATTERY=unknown;
fi


if [[ $BATTERY == true ]]; then
	echo -ne "Battery:"
	if [[ $DISPLAY ]]; then
		echo -ne "blank=on dpms=on save=on"
		xset s on
		xset +dpms
	else
		echo -n "blank=5m powersave/down=on,45m"
		setterm -blank 5
		setterm -powersave on
		setterm -powerdown 45
	fi
else
	if [[ $DISPLAY ]]; then
		echo "AC Power/Mains: blank=off save=off dpms=off"
		xset s noblank
		xset s off
		xset -dpms
	else
		echo "AC Power/Mains: powersave/down=off blank=off"
		setterm -blank off
		setterm -powersave off
		setterm -powerdown off
	fi
fi
