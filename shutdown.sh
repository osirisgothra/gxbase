#!/bin/bash
#
# ./shutdown.sh
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2014 Paradisim Enterprises, LLC
#
# shutdown (and logout) actions
#
# This script is executed LAST and launches from logout or
# from the exit alias (which afterwards exits the shell).
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

# note that the SIGUSR2 is used by gxbase to signal to all scripts that loaded something that
# they need to clean up anything they changed/allocated/created (although, this same stuff may
# also be monitoring SIGTERM/SIGKILL/SIGHUP, depending on the urgency and amount).

if [[ -z $GXBASE_RESOURCING ]] && [[ -r "$HOME/.hushlogin" ]]; then
		export GXBASE_RESOURCING=1
		source $BASH_SOURCE 1> $HOME/.gxbase-last-startup-stdout.log 2> $HOME/.gxbase-last-startup-stderr.log
		unset GXBASE_RESOURCING
		return $?
else
	if [ -z $GXBASE_ROOT ] || [ "$1" != "--gxecute@b3b9e346-47bc-4e3e-8a8a-b3b4c9a0cb3c"  ]; then
		echo -ne "Invalid Invoccation, please check your configuration: "
		[ -z "$GXBASE_ROOT" ] && echo "GXBASE_ROOT bad." || echo "gxecute code invalid."
	else
		# begin main block

		gxflag=$GXBASE_ROOT/.flag_shutdown_in_progress
		
		echo "Exiting GXBASE(xm) Version 1.2.1 (tetranary run)"
		echo "        (C)2011-2014 Gabriel T. Sharp, All Rights Reserved."
		echo "        Distributed by Paradisim Enterprises, LLC and Paradisim TK LTD"
		echo ""

		# do shutdown stuff in here --- no changes before this point ---
		
		touch $gxflag

		kill -s SIGUSR2 $$

		rm -f $gxflag 

		# do not make changes beyond this point -----

		echo ""
		echo 'Thank you for using GXBASE!!'
		sleep $[ $GXBASE_SHUTDOWN_BANNER_DELAY ]


		# set return value for gxecute	
		GXBASE_RETURN=$?
	fi
fi


