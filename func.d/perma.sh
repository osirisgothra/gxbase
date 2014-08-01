#!/bin/bash
# 
# /usr/local/gxbase/func.d/perma.sh
#   
#   Defines functionality for adding perma-vars, aliases, and functions
#   which are persistent between sessions and can be deleted in the same
#   manner.
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
# This file was re-created Sun 15 Dec 2013 02:09:53 AM EST
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#


#
# gx.perma - the meat
#
# creates/deletes a(n) alias, function, or variable
# and associates data with it. In most cases, the
# item becomes inactive/active after this call.
#
# syntax: gx.perma [kind] --name=[name] --data=[data]|--filedata=[file]|--from-existing
#         gx.perma [var|fun|las] -n [name] -dfe [value]
function gx.perma()
{
	# pre-check mode so we know it's valid and dont have to handle this down the line
	TYPE=$1; shift; case $TYPE in var);;fun);;las);;*)
		echo "Invalid mode: command mode (first argument to gx.perma) must be fun, las, or var"
		echo "If you are calling gx.perma directly, don't. Instead use permavar/permafun/permalas."
    return 1; exit 1; echo "Error: did not return after guard, script and/or memory must be corrupted!";; esac

	OPTS=`getopt -n gxbase-perma$TYPE --long name:,data:,filedata:,from-existing -o en:d:f: -- "$@"`
	if [[ $? -eq 0 ]]; then

		echo "TODO: complete this feature"
	
	else		
		return $?
	fi
}

function permavar()
{
	gx.perma var "$@"
	return $?
}

function permalas()
{
	gx.perma las "$@"
	return $?
}

function permafun()
{
	gx.perma fun "$@"
	return $?
}


