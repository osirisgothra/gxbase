#!/bin/bash
#
# alias.d/coreutils.sh
# aliases for all core programs like ls, dir, cd, cp, etc
#
# Author:
#      Gabriel T. Sharp <osirisgothra@hotmail.com>
#
# Copyright (c) 2013 Paradisim Enterprises, LLC
#
# Template for item.d/*.sh scripts
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
# Manager Notes: [0] - (I need a manager!) [1] - Make sure if you add to this file's content, that you update file-dependant
#                                                aliases which at this time are: gx.alias.edit, change the line number to match
#                                                if you changed line count. 
#                                                [[ TODO: make gx.alias.edit use a regex so we dont have to do this anymore! (INAM) ]]
#

if [ -z $GXBASE_ROOT ] || [ "$1" != "--gxecute@b3b9e346-47bc-4e3e-8a8a-b3b4c9a0cb3c"  ]; then
	echo -ne "Invalid Invoccation, please check your configuration: "
	[ -z "$GXBASE_ROOT" ] && echo "GXBASE_ROOT bad." || echo "gxecute code invalid."
else
	if [ "$2" == "" ]; then
		echo "Cant execute: no caller id was given, cant use log without it."
	else
		function protected_block() {
			shopt -s interactive_comments
				
			alias la='ls -lA --color'  # seems that --author is pointless unless on some systems (BSD?) where even then is trivial
			alias ls='ls -l --color'   # BUGFIX: changed original ls to la, and got rid of -a on current ls, like it should be

			alias gx.ld='ls -d --color'  # re-added ld as it was originally, but named it with gx. because of the linker, ld, uses that name. Also, the LightFunction lsd is simmilar and perhaps preferable, so that name is not allowed either. It's just here for those who miss it occasionally when identical usability is needed."
			alias s='sudo -H'
			alias cp='cp -v'
			alias mv='mv -v'
			alias rm='rm -v'
			alias rmdir='rmdir -v'
			alias chmod='chmod -v'
			alias chown='chown -v'
			alias chgrp='chgrp -v'
			alias chug='function chug_func() { chown -v $@; chgrp -v $@; unset -f chug_func; } chug_func'
			alias gx.alias.edit='vim coreutils.sh +61'			# see user notation about chug in /docs/text/usernotes.txt(1)
			echo -ne "$(abscol 33)Linux Core Command Aliases (ls,cp,etc)"

			# put your own coreutil aliases AFTER here, this will keep the file-dependant and edit aliases from breaking
			# (type gx.alias.edit.cu from bash to get back to this spot!) [ managers see note [1] ]

			unset -f protected_block
		}
		protected_block $2
	fi
	# set return value for gxecute	
  GXBASE_RETURN=$?
fi



