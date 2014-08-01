#!/bin/bash
#
# ldt.sh
#   
#   logical dependency tracker
#   IN DEVELOPMENT **INCOMPLETE - NOT IN USE YET**
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

for ii in func.d/*.sh
do
	echo -ne "$ii"
	depend_on=`cat $ii | grep -Po "(?<=\#depends=).*"`
	depend_ers=`cat $ii | grep -Po "(?<=\#dependants=).*"`
	if [[ $depend_on ]]; then
		echo -ne "depends on: $depend_on "
	else
		echo -ne "[depends on nothing]"
	fi
	if [[ $depend_ers ]]; then
		echo -ne "depended on by: $depend_ers"
	else
		echo -ne "[no dependants]"
	fi
	echo "."	
done

