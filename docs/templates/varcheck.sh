#!/bin/bash
#
# varcheck.sh
#   
#   Shows the values of builtin bash variables
#   Created Fri 29 Nov 2013 11:51:51 PM EST
#
#   ** FOR DEVEL / DEBUG ONLY - DO NOT INJECT INTO LIFECYCLE PATH
#
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
# 
# Copyright (C)2011-2014 Paradisim Enterprises, LLC <http://paradism.twilightparadox.com>
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

export RESULTXT=" 

 Varcheck Results
 This is a long list, press ? for more help

 ------------------------------------------------------------------------

 Parameters
	 positional
		 0=$0 
		 #=$#
		 1=$1 
		 2=$2 
		 3=$3 
		 4=$4 
		 5=$5 
		 6=$6 
		 7=$7 
		 8=$8 
		 9=$9 
		 *=$*      
		 @=$@
	 special
		 ?=$? 
		 _=$_ 
		 -=$- 
		 $=$$

 Shell Variables
 		interpreter/bash
    	BASH=$BASH 																				
 	  	BASH_ARGC=$BASH_ARGC
 	  	BASHOPTS=$BASHOPTS    															
 	  	BASHPID=$BASHPID
 	  	BASH_ARGV=$BASH_ARGV		
 	  	BASH_CMDS=$BASH_CMDS
 	  	BASH_COMMAND=$BASH_COMMAND
 	  	BASH_EXECUTION_STRING=$BASH_EXECUTION_STRING
 	  	BASH_LINENO=$BASH_LINENO
 	  	BASH_REMATCH=$BASH_REMATCH													
 	  	BASH_SOURCE=$BASH_SOURCE
 	  	BASH_SUBSHELL=$BASH_SUBSHELL
 	  	BASH_VERSINFO=$BASH_VERSINFO
 	  	BASH_VERSION=$BASH_VERSION
 	 
	 	completion
	 		COMP_KEY=$COMP_KEY		
			COMP_LINE=$COMP_LINE					
			COMP_POINT=$COMP_POINT
	 		COMP_TYPE=$COMP_TYPE	
			COMP_WORDBREAKS=$COMP_WORDBREAKS
      COMP_WORDS=$COMP_WORDS
		
		memory/process/file
			COPROC=$COPROC
			DIRSTACK=$DIRSTACK 
			HISTCMD=$HISTCMD 
			HOSTTYPE=$HOSTTYPE 
			LINENO=$LINENO 
			MACHTYPE=$MACHTYPE 
			MAPFILE=$MAPFILE 
			OLDPWD=$OLDPWD 
			OPTARG=$OPTARG 
			OPTIND=$OPTIND 
			OSTYPE=$OSTYPE 
			PIPESTATUS=$PIPESTATUS 
			PPID=$PPID 
		misc
			PWD=$PWD 
			RANDOM=$RANDOM 
			READLINE_LINE=$READLINE_LINE 
			READLINE_POINT=$READLINE_POINT 
			REPLY=$REPLY 
			SECONDS=$SECONDS 
			SHELLOPTS=$SHELLOPTS 
			SHLVL=$SHLVL 
			UID=$UID 
			BASH_ENV=$BASH_ENV 
			BASH_XTRACEFD=$BASH_XTRACEFD 
			CDPATH=$CDPATH 
			COLUMNS=$COLUMNS 
			COMPREPLY=$COMPREPLY 
			EMACS=$EMACS 
			ENV=$ENV 
			FCEDIT=$FCEDIT 
			FIGNORE=$FIGNORE 
			FUNCNEST=$FUNCNEST 
			GLOBIGNORE=$GLOBIGNORE 
		history
			HISTCONTROL=$HISTCONTROL 
			HISTFILE=$HISTFILE 
			HISTFILESIZE=$HISTFILESIZE 
			HISTIGNORE=$HISTIGNORE 
			HISTSIZE=$HISTSIZE 
			HISTTIMEFORMAT=$HISTTIMEFORMAT 
		profile
			HOME=$HOME 
		config
			HOSTFILE=$HOSTFILE 
			IFS=$IFS 
			IGNOREEOF=$IGNOREEOF 
			INPUTRC=$INPUTRC 
		locale
			LANG=$LANG 
			LC_ALL=$LC_ALL 
			LC_COLLATE=$LC_COLLATE 
			LC_CTYPE=$LC_CTYPE 
			LC_MESSAGES=$LC_MESSAGES 
			LC_NUMERIC=$LC_NUMERIC 
		window
			LINES=$LINES 
			COLUMNS=$COLUMNS
		mail
			MAIL=$MAIL 
			MAILCHECK=$MAILCHECK 
			MAILPATH=$MAILPATH 
			OPTERR=$OPTERR 
		posix-compatible 
			PATH=$PATH 
			POSIXLY_CORRECT=$POSIXLY_CORRECT 
			PROMPT_COMMAND=$PROMPT_COMMAND 
			PROMPT_DIRTRIM=$PROMPT_DIRTRIM 
		prompt/shell
			PS1=$PS1 
			PS2=$PS2 
			PS3=$PS3 
			PS4=$PS4 
			SHELL=$SHELL 
		time
			TIMEFORMAT=$TIMEFORMAT 
			TMOUT=$TMOUT 
		temporary
			TMPDIR=$TMPDIR 
		debuginfo
			FUNCNAME=$FUNCNAME=$FUNCNAME=$FUNCNAME

 -------------------------- end of list ----------------------------- 
 "
/bin/echo "$RESULTXT" | less
