#!/bin/bash
#
# ./startup.sh
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2014 Paradisim Enterprises, LLC
#
# startup script                  
#
# This script is executed SECOND and os launched by gxbase only.
# This script is responsible for the rest of the startup map:
# GXBASE EXECUTIONARY MAP  
# login
#  |
# /bin/bash (shell process started)
#  |
# .bashrc (or profile.d/gxbase on some systems)
#  |
# gxbase---+
#        startup.sh <- you are here
#          +---------+
#              |    0:builtins.sh                  <-- required BEFORE any others
#              |    1:vars.sh 2:alias.sh 3:func.sh <-- pre-init
#              |    1:bind.sh     |                <-- post-init
#           logout                +--alias exit()  <-- pre-logout
#              +------------------+----------------> shutdown.sh --> (shell process exited)
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

if (flag_exists STARTUP_CLEAR_SCREEN); then
	echo -e "[2J[0;0H"
fi
  echo "GXBASE(xm) Version $($GXBASE_ROOT/version.sh)"
	echo "(C)2011-2014 Gabriel T. Sharp, All Rights Reserved."
	echo "Distributed by Paradisim Enterprises, LLC and Paradisim TK LTD"
	echo
  GXBASE_STARTUP_COMPLETE=NO

	# <pedantry>
  # each time gxecute runs, it checks for subscripts in scriptname.d/*.sh
	# other files in those dirs are ignored and require special handling
	# note this is especially the case when utilizing vars, func, and alias
	# directories.
	# </pedantry>
  
	# pre init (builtins)
	gxecute builtins; gx.progress 45
	# main init (vars/alias/func)
	gxecute vars;			gx.progress 50
	gxecute alias;		gx.progress 60
	gxecute func;			gx.progress 70
	# post init (bind)
	gxecute bind;			gx.progress 80


  # if you are developing or forking gxbase, you might want to add other components here
	# However, if you need to add internal stuff, modify builtins.sh

  # right here, clean up things that must be set right
	gxecute cleanup;	gx.progress 90


	# set return value for gxecute	
  # NOTE: startup.d gets executed after this script returns!
	GXBASE_STARTUP_COMPLETE=YES

  GXBASE_RETURN=$?
fi



