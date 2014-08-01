#!/bin/bash
#
# ./vars
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2014 Paradisim Enterprises, LLC
#
# variable definitions
#
# variables should be initialized before functions and aliases
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
  GXBASE_VARS="$GXBASE_ROOT/vars.d"
	GXBASE_VARSXML="$GXBASE_ROOT/vars.d/vars.xml"
	GXBASE_VARSSET="$GXBASE_ROOT/vars.d/set"
	GXBASE_VARSCLR="$GXBASE_ROOT/vars.d/unset"
	GXBASE_VARSDYN="$GXBASE_ROOT/vars.d/dynamic"

	if [ -d "$GXBASE_VARS" ]; then
		for name in $GXBASE_VARS/*.vars; do
			source "$name"
		done
	fi
	


  GXBASE_RETURN=$?
fi



