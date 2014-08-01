#!/bin/bash
#
# ./alias.sh
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2014 Paradisim Enterprises, LLC
#
# alias definitions
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

if [ -z $GXBASE_ROOT ] || [ "$1" != "--gxecute@b3b9e346-47bc-4e3e-8a8a-b3b4c9a0cb3c"  ]; then
	echo -ne "Invalid Invoccation, please check your configuration: "
	[ -z "$GXBASE_ROOT" ] && echo "GXBASE_ROOT bad." || echo "gxecute code invalid."
else
	# begin main block
	
	# alias: exit     for: link to shutdown.sh
	# note: shutdown.sh can also be called when the shell is KILLed by 
	#       utilizing the trap mechanism, you'll see this in:
	# 
	alias exit='gxecute shutdown; unalias exit; if [[ -r "$HOME/.hushlogin" ]]; then builtin exit $@ > /dev/null 2>&1; else builtin exit $@; fi; true '


	# set return value for gxecute	
  GXBASE_RETURN=$?
fi



