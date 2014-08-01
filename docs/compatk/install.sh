#!/bin/bash
#
# install.sh
#   
#   installs gxbase
# 
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
#                                               
# Copyright (C)2014 Paradisim Enterprises, LLC  
#
#
# VIM SEARCH/REPLACE HELPER QUICK REFERENCE, PROVIDED FOR YOUR CONVENIENCE!
# -----------------------------------------=------------------------------------------------------+
# To the right is a test string, under each one +--------------------------=-------------------------+
# of the chars is a letter, this letter tells a | REGEX VIM MODE TEST STRINGS (PERL_REGEX)           |
# way to enter into the search box, most chars  +----------------------------------------------------+
# are literals so special expressions need a ba-| ^(?<=\s+)[a-z]*(end|finish)[read]{2,5}(?=[^a-z]*)$ | 
# ckslash before them to be considered for rege-|  BBBBBBBB      BBBBBBBBBBBB BBBB B   BBBB  B B     |
# xp at all. Use the key provided in the bottom-| L        AAAA A            A    A AAA    AA A AAAL |
#	right corner of this document for more detail	+--------------------------=-------------------------+
# +--=--+----------------------------------=------------------------------------------------------+ 
# | KEY | [ B ] Literal, you  need to use a backslash to get vim to use it as regular expression  |
# |__-__/ [ L ] Non-Literal, unless \ is used, is a regex char  [ A ] Literal, if unterminated *  |
# +--~-------------------------------------=------------------------------------------------------+
# * unterminated means string "[unterminated" would be literal (in search, not text), but "[terminated]"
#   would also match stuff like "term" "mediate" "reddit" "traindamn" "narnia" and more!...
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

echo "Warning: this is an old installer, use at your own risk."
echo "PRESS CTRL+C TO CANCEL, ANY OTHER KEY TO PROCEED"
read

# keep data in variables as much as possible, so things stay consistent throughout the
# installation process, set expected shell parameters and variables:
DEBUGMODE=OFF
function decho()
{
	if [[ $DEBUGMODE == OFF ]] || [[ -z $DEBUGMODE ]]; then
  # put attempted flags into log too
		printf -- "$*" >> ~/gxbase-install.log
	elif [[ $DEBUGMODE == ON ]]; then
		printf "$@" 
	else
		echo "DEBUGMODE incorrectly set in install.sh, please fix this"
	  return 221
	fi
}
if (decho == 221); then return 1; fi

# shell options: comments can follow commands, shift command never fails, * no-match yields nothing
# and * also includes files starting with dots (.) but not ".." and "." (best way to find "ALL" files)
shopt -s interactive_comments
shopt -u shift_verbose
shopt -s nullglob
shopt -s dotglob

# tasty functions            IFF[varname,output_if_set,output_if_empty_or_unset]
function IFF() { [[ ${!1} ]] && printf -- "$2" || printf -- "$3"; }
function g_dry_dialog() 
{ 
	echo "$D_HR"; echo "dialog run with parameters:"; 
	echo "1 = $1";      echo "2 = $3";
	echo "3 = $2";      echo "4 = $4";
	shift 4
	echo "REST = $*";
	echo "<< end dialog >>"
	echo "$D_HR"
	echo "PRESS A KEY TO PROCEED PAST THIS DIALOG OR TYPE A NUMBER TO SIMULATE A RETURN CODE"
	echo "$D_HR"
	read RETCODE
	# only the first item (w/o space) is taken from reply, rest is dropped, if it is alpha, it ends up being zero
	# if not, the proper representation is as much as can be with bash's help.
	declare -i RETVAL=${RETCODE/* }
	return $RETVAL
}

function g_dry_cmd()
{
	echo "$D_HR"
	echo "Command: $1 ($2)"
	shift 2
	echo " Params: $*"
	echo "$D_HR"
	echo "Command Result (You can test to see how the result is responded to)"
	echo "this command should..."
	select res in succeed fail; do break; done
	declare -i RETVAL=$[ REPLY - 1 ]
	echo "$D_HR"
	return $RETVAL	
}

# runtime modification variables
# and command mapping
DRY_RUN=NO                      # NO=normal 'wet' commands, YES=only print changes that would be done (no writing, anywhere!) use for testing!
[[ $1 == --dry-run ]] && { DRY_RUN=YES; echo -ne "\n\n\n\n\n\n\n\n\n\t\t\t\t\t********* DRY RUN ************"; sleep 2; clear; }

# dry/wet mode conditional commands
if [[ $DRY_RUN == YES ]]; then
	G_DRY=g_dry_cmd
	DLG=g_dry_dialog
	CP="$G_DRY cp copy-a-file-system-object"
	MV="$G_DRY mv moveafilesystemobject"
	MKDIR="$G_DRY mkdir makefilesystemdirectoryrelative[ornot]tothisone"
	CHMOD="$G_DRY chmod changeafileaccesspermissions"
	TOUCH="$G_DRY touch open+closeafilesystem object"
	RM="$G_DRY rm removeafilesystemobject"
	RMDIR="$G_DRY rmdir removefilesystemdirectory"
	#
else
	# use these commands, not the originals, lets us replace them later with better ones
  DLG=dialog
#--------------------------------------------------------------------------------------------------------------------------------------
#  section: disabled [incomplete]
#  purpose: adds the ability to install from GUI without the terminal (ie, from dolphin, or nautilus)
#           but don't use it, it is unfinished and definitely NOT tested to not cause damage, this is 
#           more relevant with this than the other stuff!!
#--------------------------------------------------------------------------------------------------------------------------------------
#	if (! tty -s) && [[ $DISPLAY ]] && [[ -x /usr/bin/gdialog ]]; then
#		DLG=gdialog
#	elif [[ $1 == --gui ]]; then
#
#		if [[ $DISPLAY ]] && [[ -x /usr/bin/gdialog ]]; then
#			DLG=gdialog
#		else			
#			if (xprop -root 2> /dev/null 1>&2); then
#				if (gdialog 2> /dev/null); then
#					DLG=gdialog
#				elif (Xdialog 2> /dev/null); then
#					DLG=Xdialog
#				else
#					NODLGPRG=2
#				fi
#			else				
#				NODLGPRG=1
#			fi
#
#			if [[ $NODLGPRG ]]; then
#				echo -e "WARNING: you can't use --gui mode, because:\n"
#    		[[ -z $DISPLAY ]] && echo -e "\t * The DISPLAY variable is not set"
#  	    [[ -x /usr/bin/gdialog ]] || echo -e "\t * You don't have gdialog from package (zenity)"
#				[[ $NODLGPRG -eq 2 ]] && echo -e "\t * You don't have Xdialog"
#				return 2> /dev/null
#				exit				
#			fi			
#		fi
#	else
#		DLG=dialog
#	fi
# - end section disabled -
#---------------------------------------------------------------------------------------------------------------------------------------

  CP=cp
	MV=mv
	MKDIR=mkdir
	CHMOD=chmod
	TOUCH=touch
	RM=rm
	RMDIR=rmdir
	#
fi
# extra command mapping for others used in the script, see script
ECHO=echo
READ=read
CLS=clear
SLEEP=sleep
UNSET=unset #not much point, but its here anyway, just in case  *not used*
# 
# init stuff:
# set the COLUMNS and ROWS variables, if possible (for our use AND DIALOG's)
# fixup terminal behavior if needed
eval `resize`
setterm -reset
setterm -init
if [[ -z $TERM ]]; then
	$ECHO  "WARNING: TERM not set, defaulting to the well known 'linux' terminal, please check system settings..."
	$SLEEP 2
	TERM=linux  #temporary fix because DIALOG needs a TERM variable
else
	$ECHO "Terminal: $TERM ok!"; sleep 1
fi

# local data: authors/forkers: changes should be made HERE not in the script so dont change script strings!! 
C_NAME_FIRST="Gabriel"
C_NAME_MIDDLE="Thomas"
C_NAME_LAST="Sharp"
C_NAME_EMAIL="osirisgothra@hotmail.com"
C_NAME_WEB="http://gitorious.org/gxbase"
C_NAME_LIC="(C)2014 Paradisim Enterprises, LLC, All Rights Reserved - See LICENSE For Details."
PV="1.0 alpha"
PN="GXBASE $PN"
BT="$PN Installation Program"

# begin old startup file determination - depreciated
#if [[ -r $HOME/.login ]]; then
#	B_SRC="$HOME/.login"
#elif [[ -r $HOME/.profile ]]; then
#	B_SRC="$HOME/.profile"
#else
#	if [[ -r "$HOME/.bashrc" ]] || (touch "$HOME/.bashrc"); then
#		B_SRC="$HOME/.bashrc"
#	elif (touch "$HOME/gxbase-startup.sh"); then
#		echo "Can't write $HOME/.bashrc, your going to have to manually execute $HOME/gxbase-startup.sh when you begin!"
#		B_SRC="$HOME/gxbase-startup.sh"
#	else
#		echo "CANNOT write anything in your home directory, install aborted!"
#		B_SRC="/dev/null"
#		exit 1
#		return 1 ;# source guard
#	fi
#fi
# CHANGE: no longer autodetect in this way
# new implementation should be this:
# check for files .bashrc | .bash_profile and .profile
RESPONSE="$HOME/.cache/gxbase-response$RANDOM-file.txt"
PERSPAWN="$HOME/.bashrc"
if [[ -r $HOME/.bash_profile ]] && [[ -r $HOME/.profile ]]; then
	dialog --radiolist "You have a .profile but no .bash_profile in your home folder, $HOME. You should not use .profile for per-login startup. Which should be used for per-login startup of the bash shell?" 0 0 2 .bash_profile "Bash Per-Login Script (recommended)" on .profile "General Per-Login Script (use at own risk!)" off 2> $RESPONSE
	PERLOGIN="$HOME/$(cat $RESPONSE)"
	if [[ ! -r "$PERLOGIN" ]]; then
  	clear
		echo "$BN Cancelled."
    return 1; exit 
	fi
else
	PERLOGIN="$HOME/.bash_profile"
fi
# verify user has access to these files before proceeding
# since the HOME variable could have been tampered with 
# (ie, some place other than the user's home where permissions are bad)
for i in "$PERLOGIN" "$PERSPAWN"; do
	if (! touch "$i"); then
		clear
		echo "Error accessing $i, aborting"
	  return 2; exit
  fi
done
# ask user whether they want a per-login or per-shell setup
DMSG="You can either have GXBASE start up only when logging in (this happens before running X, not when running a terminal). Alternatively you can have GXBASE run everytime bash is invoked. Beware that subshells will also invoke this behavior since aliases/functions can't traverse the shell process barrier."
OPT1="Per Shell Execution (useful for X users)"
OPT2="Per Login Execution (better suited for single-shell console users)"
dialog --radiolist "$DMSG" 0 0 2 "$PERSPAWN" "$OPT1" on "$PERLOGIN" "$OPT2" off 2>$RESPONSE
if [[ -r $RESPONSE ]]; then
	B_BASE="$(basename `cat "$RESPONSE"`)"
	B_SRC="$(cat $RESPONSE)"
else
	clear
	echo "Aborted Installation of $BN"
	return 3; exit
fi

# CHANGE: added user-uid-hostname-random part to tempfile to prevent 
#         cross-install / simultaneous installs to become corrupt or have permission errors
B_TMP="/tmp/$B_BASE-$USER-$UID-$HOSTNAME-$RANDOM-org.tmp"
B_OK="/tmp/$B_BASE-$USER-$UID-$HOSTNAME-$RANDOM-ok.tmp"
B_BAK="$HOME/$B_BASE~.old"
G_DIR="$HOME/.config/gxbase"
G_PFX="GXBASE_ROOT"
G_SRC="$PWD"
G_SIG="ADDED_BY_GXBASE_${PV}_DONT_REMOVE_ME"
DIALOGRC="$G_SRC/gxbase.dialogrc"
if [[ -z $COLUMNS ]]; then
	D_HR="-----------------------------------" # small rule for dumb/ascii-windowed terminals
else
	D_HR=`for ((i=0;i<$COLUMNS;i++)); do printf -- -; done` #horizontal rule (automatic size limited to window/term width)
fi
C_INF="$C_NAME_FIRST ${C_NAME_MIDDLE:0:1}. $C_NAME_LAST (author) email: <$C_NAME_EMAIL>\nGet latest version from <$C_NAME_WEB>\n$C_NAME_LIC"
C_STR="$D_HR\nContact Information\n$D_HR$C_INF$D_HR\n"

# CHANGED: added cleanup function so files don't get left behind in public places
function f_cleanup()
{
	rm -f $B_TMP $B_OK
}


# shell variables: use default in-line field separator (IFS) and include scripts in gxbase/bin so we
# can use them as helpers during the installer's lifetime.
unset IFS
PATH=$PATH:$G_SRC/bin

# even though we know where everything is, don't going haphazardly changing directories
# our script can take it but we must not forget that other people's stuff could break
# if we go and do this in the midst (like DIALOGs) and DO NOT USE CHROOT PROGRAMS during installation!

# main script: starts here

if [[ $UID -eq 0 ]]; then 
	G_PASS=AGREE
	$ECHO -ne "You are root, installing $PN as root can cause unforseen problems and could affect "
	$ECHO -e "system security. If you really want to proceed, you must type $G_PASS to continue:" 
	unset G_ANS 
	$READ G_ANS
 	if [[ $G_ANS != $G_PASS ]]; then
		# will insert "Passé phrase "EXAMPLE" was incor.."  or "Passé phrase incorr"
	$ECHO "Passé phrase${G_ANS+ \"}$G_ANS${G_ANS+\" was} $(IFF G_ANS incorrect missing), user NOT accepting, halting install!" 
 		G_HALT=YES
 	else
 		unset G_HALT
 	fi
fi

if [[ -z $G_HALT ]] && [[ -r ./.gxbase.locator.stamp.uuid ]]; then
	if ($DLG --backtitle "$BT" --yesno "This program will install $PN for $USER ($UID), proceed?" 0 0); then
    $DLG --infobox  "Starting $PN Install..." 0 0
		$SLEEP 0.4
		# pseudocode begin
		# 1) figure out our PWD
		# 2) ask user if it's ok to write to .bashrc
		# 3) write files
		# 4) create ~/.config/gxbase
		# 5) write ~/.config/gxbase/GXBASE_ROOT with PWD		
		# 6) cleanup to prevent problems with permissions,etc later [in case temp files are in public places, which should be changed]
		# pseudocode end
		$TOUCH $B_SRC
		$CP $B_SRC $B_TMP
		$ECHO "source $G_SRC/gxbase" >> $B_TMP
		$ECHO 'PATH=$PATH:'"$G_SRC:$G_SRC/bin" >> $B_TMP
		$ECHO "#${G_SIG}#" >> $B_TMP
		$DLG --backtitle "$BT" --title "Verify the changes to your $B_SRC" --ok-label "Accept Changes (No Undo!)" --editbox $B_TMP 0 0 2> $B_OK
		if [ -s $B_OK ]; then
			$MV -f $B_SRC $B_BAK
			$MV -f $B_OK $B_SRC
			# -drwx-wx--- permission change
			$MKDIR -pm 760 $G_DIR
			# -d???rwx??? permission change
			$CHMOD g+rwx $G_DIR/.. $G_SRC
      # insert prefix pointer to proper place for next start
			$ECHO "$G_SRC" > $G_DIR/$G_PFX
	    $DLG --backtitle "$BT" --msgbox "$PN has been installed, please log out and back in for the changes to take effect. Your original $B_SRC has been copied to $B_BAK for safe keeping, you may restore it to undo the install later, see documentation for details on uninstalling." 0 0
			$CLEAR
			$ECHO "Thank you for installing $PN, please write to the author for help or comments!"
		else
			$CLEAR
			$DLG --backtitle "$BT" --title "Install Aborted" --msgbox "$PN install aborted because you did not approve the changes to your $B_SRC, if you want to use $PN without it, install it manually in the proper place!"
			$ECHO "Install aborted! [source unverified by user]"
		fi
	else
 		$DLG --keep-window --infobox "$PN Installation Cancelled, Press Any Key To Exit" 0 0	 
		$READ
 		$DLG --keep-window --infobox "Exiting..." 0 0	  	
		$SLEEP 0.2
		$CLEAR
		$ECHO "Install aborted!"
	fi	
else
	$ECHO "Please start the installation in the directory $PN is unpacked in."
fi

# end point: always end by giving contact info!
$ECHO -e "$C_STR"

