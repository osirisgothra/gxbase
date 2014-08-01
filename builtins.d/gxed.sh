#!/bin/bash
#
# ./builtins.d/gxed.sh
#   
#   GXBASE File Editing Helper Script
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
# This file was created: 
#
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#

echo -ne "$(abscol 33)gx file editor helper script"

function gxfuned_func()
{
	echo "searching gxbase tree for that/those files..."
	pushd . > /dev/null 2>&1
	cd "$1"
	shift
	while [ "$1" != "" ]; do
		if [ -z "$results" ]; then
			results+=$(find -iname "$1")
		else
			results=$(find -iname "$1")
		fi
		shift
		echo "$# to go..."
	done
	/usr/bin/vim $results
}

alias gxed="gxfuned_func $GXBASE_ROOT"

   
