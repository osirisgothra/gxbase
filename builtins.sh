#!/bin/bash
#
# ./builtins.sh
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2014 Paradisim Enterprises, LLC
#
# builtin definitions 
#
# This script is executed FIRST during startup.sh's invoccation
# because it installs all the INTERNAL functions, aliases, and
# variables that are used during startup. By definition, the   
# content defined in this script shouldn't be used beyond the  
# gxbase startup scripts because that is what the other scripts
# are for. It would be redundant to place any external or exported
# items in here because this is the purpose of the scripts executed
# after this script.  Functions and variables should not be exported
# and aliases will usually be self-destructive (unalias is the last
# command in the alias, and usually invoked/defined by a supporting
# internal function). Although some variables are local by nature,
# you cannot declare local unless you are within a function when running
# at the shell level (as gxbase does). For this reason, the entire 
# body of this script is defined as a function and then run. This 
# enables the use of the [local] keyword however you may NOT use it
# outside the function body!
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
	# use a function to guard local varaibles
	function builtins_guard()
	{
		if (grep -Poq "^[ ]*export" "$GXBASE_ROOT/vars.d/gxbase.vars"); then
			echo "Warning: export(s) found in gxbase.vars, which is not allowed, the script may fail. Fix this problem to resolve the problem. For safety reasons the script will NOT be evaluated."
		else
			echo -ne "Loading internal variables..."
	    eval `grep -Po "^[^# ]+=[^# ]+" "$GXBASE_ROOT/vars.d/gxbase.vars" | sed "s/^/export /g"`
			if [ $? -eq 0 ]; then
				echo "Done"
			else
				echo "Error($?)"
			fi
		fi
		#cat ./vars.d/gxbase.vars | grep "^[^#].*$" | sed "s/^/export /g"

  	unset -f builtins_guard
	}
	builtins_guard 

	# set return value for gxecute	
  GXBASE_RETURN=$?
fi
