#!/bin/false
#
# 002-notify.sh
#   
#   Notifications
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
# This file was created March 17, 2014
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#
echo -ne "$(abscol 33)notifications"
#
if [[ -f /run/reboot-required ]]; then
	if [[ -r ~/.hushlogin ]]; then
		if (flag_exists GXBASE_NOREBOOT_NOTIFICATIONS); then
			false DOING_NOTHING_BECAUSE_THE_FLAG_GXBASE_NOREBOOT_NOTIFICATIONS_IS_SET
		else
			echo "System says a reboot is really needed, you probably should do that soon!" > $(tty)
		fi
	fi
fi
