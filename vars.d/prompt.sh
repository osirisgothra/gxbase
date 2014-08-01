#
# /usr/local/gxbase/vars.d/prompt.sh
#   
#   Prompt Variables (PS1,PS2,PS3,...)
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
# This file was created 
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#


# NOTE: the helpers for the prompt are set in gx.prompt.sh in func.d!

if [ -z $GXBASE_NOPROMPTSET ]; then
    echo -e "$(abscol 33)BASH Command Line Prompts (PS[1-3])"
		eval
		if [ -z $COLUMNS ]; then
			# force bourne shell commands (sh style, which is used in POSIX sh-compatible bash)
			eval $(resize -u)
		fi
		COLUMNS=$[ $COLUMNS + 0 ]
		[ $COLUMNS -lt 50 ] && GX_NARROW=1
		[ ! -z $GX_FLAG_FORCENARROW ] && GX_NARROW=1
		if [ "$GX_NARROW" != "1" ]; then
			# longer prompt giving more information, but reserving-on-nonuse 
			# which means certain things dont show unless they are valid
			PS1='$USER $(gx_getprompt) $(tty|grep -Po "(?<=/dev/).*"|tr "/" "\0"|sed "s/pts/X `command ls -l | grep "$USER" -c`@/g") $# $SHLVL \!-\#:\w: '
			PS2='(complete the delimiter to stop editing): '
			PS3='select> '
		else
			# shorter prompt for limited windows, always the same and not
			# dynamic either
			PS1=\\w:
			PS2='..>'
			PS3='>>'
		fi
		[ ! -z $GX_NARROW ] && export GX_NARROW
fi
