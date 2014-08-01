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
# gxbase vers: see version.dat in gxbase directory or type gx.version[enter]
# file version: 0.1.0-5 (this can be different than the entire gxbase version)
#
# Revision History
# ----------------
# 0.1.0-1         initial pre-release
#    .0-2         fixed problem when installing in non-static locations (not /usr/local/gxbase)
#    .0-3         added ability to install per-user and non-priv/admin installs
#    .0-4         reorganized script, added checks for packages, terminal detachment, priv checks,
#                 and support for .profile use, or .bash_profile use as opposed to .bashrc use
#    .0-5         milestone: halfway point to first beta release (which will be called 0.2.0-beta-1)
#

# NEW FILE LAYOUT
# please keep all sections separated by two empty lines
# all description section comment TITLES are to be in UPPERCASE and one line long
# only, the following description lines should be between 3-8 lines and in 
# lowercase form. Make sure to group them with the same subject/script code.
# if comment does not header a set of code, make sure to terminate it like so:
#################################################################################

# TERMINAL ATTACHED CHECK
# check for:
# * launched indirectly (like from a daemon or scheduler)   
# * launched w/o terminal (like from an X-based or some other non-terminal source)
# * launched redirected so no I/O can reach the user in question (unattended install not supported!)
# must be done first since all other checks may require user interaction and have feedback as well
# make sure the "return" command is used before all "exit" commands, in case the script was sourced
if (! tty -s); then
	MSG="GXBASE $BASH_SOURCE: Detached terminal install not yet supported, please install from a terminal" 
	if [[ ! -z $DISPLAY ]]; then
		zenity --infobox $MSG
  else		
		# cant write to notify, last resort is to attempt a write to stdout and syslog simultaneously:
	  logger -s "$MSG"
	fi
	return 255; exit 255
else
	# user can see us, so lets let them know...
	echo "Terminal verifidicly attached to $(tty)."
fi


# SOURCE EXECUTION CHECK
# source guard, so the script doesn't have to worry about whether to use 'exit' or 'return'
# note that we have to use "return" here because if we use "exit" we'll exit the interactive shell
case $- in
	*i*)
		echo "stop: do not source this script, run it like this: ./install.sh"
		return 6
		;;
esac


# BASH VERSION CHECK, this is compatible with older versions but we need
# version >= 4.0 to use GXBASE although >= 3.0 may work 90% of the time
# as a rule we follow this "philosophy":
# bash version < 3.0: do not install (abort)
# bash version >= 3.0 and < 4.0, ask if user wants to 'risk it'
# bash version >= 4.0, silently succeed
# note that the 'compatXX' shopt do not count here
if [[ -z $BASH_VERSION ]]; then
	echo "stop: BASH_VERSION not defined, you are probably not using bash, GXBASE requires bash. please use a real copy of bash, not a clone."
	echo "note: make sure that you do not have bash.bashrc or ~/.bashrc changing the value of the BASH_VERSION variable, as it is not read only."
	exit 7
else
	# fetch the major version, works on ALL versions of bash up to and including 4.x
  declare -i BASH_VERMAJ=${BASH_VERSION: 0:1}
	if [[ $BASH_VERMAJ -lt 3 ]]; then
		echo "stop: your bash shell's version ($BASH_VERSION), is too old, please install the latest version of the bourne again shell."
		exit 8
	elif [[ $BASH_VERMAJ -lt 4 ]]; then
		echo "Warning: your bash shell's version ($BASH_VERSION), is not >= 4, GXBASE may work most of the time but some features may be broken. It is recommended that you install the latest version before installing. You can however continue AT YOUR OWN RISK:"
		echo -ne "Install Anyways [not recommended] [y/n]:"
		unset REPLY
		while [[ $REPLY != "y" ]] && [[ $REPLY != "n" ]]; do
			read -sn1
		done
		case $REPLY in 
			*y*)
				echo "Proceeding with install AT YOUR RISK..."
				sleep 3
				;;
			*n*)
				echo "Aborting the installation. Please install a newer (>=4.0.0) version of the bourne again shell (bash)."
				echo "questions/comments: osirisgothra@hotmail.com"
				sleep 3
				exit 9
				;;
		esac
	else
		echo "Bash version successfully detected as a compatible version ($BASH_VERSION is >= 4.0.0), continuing installation..."
	fi
fi



# HOME VARIABLE CHECK
#  since we rely on this, we must know that it is in tact
#  users can change this, it can be damaged, unset, etc
# $HOME must be non-empty, belong to the user, be readable, and match the bash directory ~
# this is a loop which guarentees and gives the user multiple chances to exit if something goes wrong
# the isowner() function guarantees that a string is: 1) a dir  2) is r/w/x by user  3) belongs to user
function isowner()
{
	if [[ -z $* ]]; then
		echo "variable is empty"
		return 1;
	elif [[ ! -d $* ]]; then
		echo "$* is not a directory"
		return 1;
	elif [[ ! -r $* ]] || [[ ! -x $* ]] || [[ ! -w $* ]]; then
		echo "$* is not r/w/x-able"
		return 1;
	else
		# correct user if needed
		export USER=$(whoami)
		echo "Current user: $USER"
		# do NOT make this variable an integer value or you will get false positives
		local THEOWNER=$(stat "$*" --format="%U")
		echo "Owner of $*: $THEOWNER"
		if [[ $THEOWNER == $USER ]]; then
			echo "Owner and User Match, Ok"
			return 0
		else
			echo "Owner and User Mismatch, Fail"
			return 1
		fi
	fi	
	
}
while [[ -z $OKTOBREAK ]]; do
	if [[ -z $HOME ]] || [[ ! -r $HOME ]] || [[ $HOME != ~ ]] || ( ! isowner $HOME ); then
		echo "the HOME variable is not valid!"
		echo "Sync it with the current user's home directory [y/n]?"
		unset REPLY
		while [[ $REPLY != y ]] && [[ $REPLY != n ]]; do
		read -sn1
		done
		case $REPLY in
			*y*)
			# correct HOME variable
			export HOME=~
			# the HOME fix only affects this script and subscripts
			echo "WARNING: when you exit this program, the HOME variable is still wrong in the parent process, you may want to figure out why this is. Refer to your shell's documentation for more information on this"
			sleep 3
			;;
			*n*)
			echo "can't continue without a valid HOME variable, stop."
			exit 9;
		esac
	else
		echo "HOME variable is valid."
		OKTOBREAK=1
		unset -f isowner
		break
	fi	
done
unset OKTOBREAK REPLY THEOWNER



# INSTALL A CLEANUP HANDLER
# added cleanup function so files don't get left behind in public places
# make sure any additional files get added here so we don't make a mess
# literals ($1): "1"              = default=remove temp files 
#                "response"       = remove response file
function f_cleanup()
{
	case $1 in
		*response*)
			rm -f "$RESPONSE";;
		*)
			rm -f $B_TMP $B_OK;;
	esac
}


# DEBUG MODE SUPPORT
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
decho; if [[ $? == 221 ]]; then return 1; fi


# REQUIRED PACKAGE PRE-CHECK
# precheck for packages before install
# this is important because we need these packages not only to
# use the GXBASE environment but also the rest of the install
# will need some of these packages as well (dialog, for example)
# note: do not use dialog before package check - in case you are wondering why i didnt use dialog before here
if (! source ./precheck.sh); then
	echo "Main Install Halted."
	exit 5;
else
	echo "Package check succeeded, Main Install Resumed:"
fi


# SET BASH SHELL OPTIONS
# shell options: comments can follow commands, shift command never fails, * no-match yields nothing
# and * also includes files starting with dots (.) but not ".." and "." (best way to find "ALL" files)
shopt -s interactive_comments
shopt -u shift_verbose
shopt -s nullglob
shopt -s dotglob


# SET UP INSTALLER FUNCTIONS
# includes:         quick description                   proper syntax
#   IFF							Single line QC style "IF" scanner 	[varname,output_if_set,output_if_empty_or_unset]
#   g_dry_dialog    used for debugging the installer  	[main kind,dialog parameters]
#   g_dry_cmd				used to wrap a command for debug    [command,command parameters]
function IFF() 
{ 
	[[ ${!1} ]] && printf -- "$2" || printf -- "$3"; 
}
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


# VARIABLES FOR ENTIRE INSTALLER
# 	this includes:
#   * dry-run variables				    * command variables
#   * dialog global variables     * builtin-mapped variables (echo,etc)
#  when DRY_RUN is YES, nothing gets done but we can see how it would be done
#  which is nice for debugging the installer script, esp. when it gets bigger!
#  the first DRY_RUN is the static setting for DRY_RUN, for prolonged dry testing.
#  for single or temporary dry run, use the --dry-run argument -- no indentation please (keep simple)
DRY_RUN="NO"; if [[ $1 != --no-dry-run ]] && [[ $DRY_RUN == YES ]] || [[ $1 == --dry-run ]]; then
DRY_RUN=YES
DRY_RUN_MSG="\n\n\n\n\n\n\n\n\n\t\t\t\t\t********* DRY RUN ************" 
G_DRY=g_dry_cmd
DLG=g_dry_dialog
CP="$G_DRY cp copy-a-file-system-object"
MV="$G_DRY mv moveafilesystemobject"
MKDIR="$G_DRY mkdir makefilesystemdirectoryrelative[ornot]tothisone"
CHMOD="$G_DRY chmod changeafileaccesspermissions"
TOUCH="$G_DRY touch open+closeafilesystem object"
RM="$G_DRY rm removeafilesystemobject"
RMDIR="$G_DRY rmdir removefilesystemdirectory"; else
DLG=dialog
CP=cp
MV=mv
MKDIR=mkdir
CHMOD=chmod
TOUCH=touch
RM=rm
RMDIR="rmdir"; fi
ECHO=echo
READ=read
CLS=clear
SLEEP=sleep
UNSET=unset
C_NAME_FIRST="Gabriel"
C_NAME_MIDDLE="Thomas"
C_NAME_LAST="Sharp"
C_NAME_EMAIL="osirisgothra@hotmail.com"
C_NAME_WEB="http://gitorious.org/gxbase"
C_NAME_LIC="(C)2014 Paradisim Enterprises, LLC, All Rights Reserved - See LICENSE For Details."
PV="1.0 alpha"
PN="GXBASE $PN"
BT="$PN Installation Program"
RESPONSE="$HOME/.cache/gxbase-response$RANDOM-file.txt"
PERSPAWN="$HOME/.bashrc"
PUC_DMSG="You can either have GXBASE start up only when logging in (this happens before running X, not when running a terminal). Alternatively you can have GXBASE run everytime bash is invoked. Beware that subshells will also invoke this behavior since aliases/functions can't traverse the shell process barrier."
PUC_OPT1="Per Shell Execution (useful for X users)"
PUC_OPT2="Per Login Execution (better suited for single-shell console users)"
G_ANS="AGREE"
G_HALT="NO"



# PREPARE TERMINAL FOR DIALOG MODE
#  this includes:
#   * alert for dry run if applicable									      
#   * reset and init the terminal via setterm
#   * ensure terminal dimensions with resize
#  if the terminal has not TERM variable, the default "linux" will be assigned
if [[ $DRY_RUN == YES ]]; then
	echo -ne "$DRY_RUN_MESSAGE"
	sleep 2
fi	
$CLS
eval `resize`
setterm -reset
setterm -init
if [[ -z $TERM ]]; then
	$ECHO  "WARNING: TERM not set, defaulting to the well known 'linux' terminal, please check system settings..."
	$SLEEP 2
	export TERM=linux  #temporary fix because DIALOG needs a TERM variable
else
	$ECHO "Terminal $TERM reinitialized."; sleep 1
fi


# PREPARE USER CONFIGURATION FILES I : PICK PROFILE TYPE
#  check for profile/bash_profile and pick one
#   in case user only uses bash they can use .profile safely
#  otherwise they should use .bash_profile however, it will then skip .profile
if [[ -r $HOME/.bash_profile ]] && [[ -r $HOME/.profile ]]; then
	$DLG --radiolist "You have a .profile but no .bash_profile in your home folder, $HOME. You should not use .profile for per-login startup. Which should be used for per-login startup of the bash shell?" 0 0 2 .bash_profile "Bash Per-Login Script (recommended)" on .profile "General Per-Login Script (use at own risk!)" off 2> $RESPONSE
	if [[ $? -eq 0 ]] && [[ -r $HOME/$(cat $RESPONSE) ]]; then
		PERLOGIN="$HOME/$(cat $RESPONSE)"
	else	
  	clear
		echo "$BN Cancelled."
    exit 1
	fi
else
	PERLOGIN="$HOME/.bash_profile"
fi


# PREPARE USER CONFIGURATION FILES II: PICK CONFIGURATION
#  verify user has access to these files before proceeding
#  * since the HOME variable could have been tampered with 
#     for example, some place other than the user's home where permissions are bad
#  * ask user whether they want a per-login or per-shell setup (bashrc/bash_profile)
for i in "$PERLOGIN" "$PERSPAWN"; do
	if (! touch "$i"); then
		clear
		echo "Error accessing $i, aborting"
	  exit 2
  fi
done
$DLG --radiolist "$PUC_DMSG" 0 0 2 "$PERSPAWN" "$PUC_OPT1" on "$PERLOGIN" "$PUC_OPT2" off 2>$RESPONSE
declare -i RETV=$?
if [[ $RETV == 0 ]]; then
	if [[ -r `cat $RESPONSE` ]]; then
		B_SRC="`cat $RESPONSE`"	
		B_BASE="`basename $B_SRC`"
	else
		clear
		echo "Aborted install (cant read `cat $RESPONSE` from RESPONSE=[$RESPONSE])"
		echo "Stopping install of $BN"
		exit 31
	fi
else
	clear
	echo "Dialog Gave Bad Result: RETURNCODE=$RETV"
	echo "Aborted Installation of $BN"
	exit 3
fi


# PREPARE USER-CONFIGURATIONN DEPENDANT VARIABLES
#  now we set the variables that are dependant on the questions asked in the last section
#  * set the temporary and user's file paths
#  * set the horizontal rule since by now the COLUMNS variable should be well tested
#  * make tempfiles have names that wont interfere with paralell installs
#  * make IFS (file separator) empty for now, unset it when cleaning up
#  once again I'll say it, keep indentation clean at 0chars, and bury the if-else-fi
B_TMP="/tmp/$B_BASE-$USER-$UID-$HOSTNAME-$RANDOM-org.tmp"
B_OK="/tmp/$B_BASE-$USER-$UID-$HOSTNAME-$RANDOM-ok.tmp"
B_BAK="$HOME/$B_BASE~.old"
G_DIR="$HOME/.config/gxbase"
G_PFX="GXBASE_ROOT"
G_SRC="$PWD"
G_SIG="ADDED_BY_GXBASE_${PV}_DONT_REMOVE_ME"
DIALOGRC="$G_SRC/gxbase.dialogrc"; if [[ -z $COLUMNS ]]; then
D_HR="-----------------------------------"; else
D_HR=`for ((i=0;i<$COLUMNS;i++)); do printf -- -; done`; fi
C_INF="$C_NAME_FIRST ${C_NAME_MIDDLE:0:1}. $C_NAME_LAST (author) email: <$C_NAME_EMAIL>\nGet latest version from <$C_NAME_WEB>\n$C_NAME_LIC"
C_STR="$D_HR\nContact Information\n$D_HR$C_INF$D_HR\n"
PATH=$PATH:$G_SRC/bin
IFS=""



# MAIN INSTALLATION BEGINS HERE
# DO NOT DECLARE NEW VARIABLES BEYOND THIS POINT
#  * installs gxbase by modifying shell startup file(s)
#  * creates it's own configuration  in ~	/.config/gxbase
#  * ensures that startup succeeded
#  * puts flags for first-time-run messsages
#  * cleans up temporary files, backs up files that were modified in simmilarly named locations
# this is the end of the script and should not have any major sections beyond this point
# if you have code to contribute, put it before this block. Remember to put variables
# into the variable block!
if [[ $UID -eq 0 ]]; then 
	$ECHO -ne "You are root, installing $PN as root can cause unforseen problems and could affect "
	$ECHO -e "system security. If you really want to proceed, you must type $G_PASS to continue:" 
	unset G_ANS 
	$READ G_ANS
 	if [[ $G_ANS != $G_PASS ]]; then
		# will insert "Passé phrase "EXAMPLE" was incor.."  or "Passé phrase incorr"
	$ECHO "Passé phrase${G_ANS+ \"}$G_ANS${G_ANS+\" was} $(IFF G_ANS incorrect missing), user NOT accepting, halting install!" 
 		G_HALT=YES
	else
		# TODO: 4: nest #3 into this space, to avoid anti-nest variables (ANVs)
 		unset G_HALT
 	fi
fi
# TODO: 3: nest into #4 to ensure proper flow when reading/debugging (doesnt affect funtion)
if [[ $G_HALT != YES ]] && [[ -r ./.gxbase.locator.stamp.uuid ]]; then
	if ($DLG --backtitle "$BT" --yesno "This program will install $PN for $USER ($UID), proceed?" 0 0); then
    $DLG --infobox  "Starting $PN Install..." 0 0
		$SLEEP 0.4
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
			# warnings for components that may be missing
			# this file is deleted after the first run of gxbase (per user)
			touch ~/.gxbase-enable-pre-run-first-time-warnings
			if [[ $UID -eq 0 ]]; then
				# TODO: this notice is temporary, read TODOs #1 and #2
				echo "Notice: per-user first time warnings not yet in place, you will have to turn them on yourself."
				read
				# TODO: 1: ask root if s/he wants per-user warnings for first time messages, and then 
				# TODO: 2: automate ftwf creations if asked to do so
			fi
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



# FINAL CLEANUP
# clean up and end by posting the contact method
# so users can always contact no matter how bad the script messes up :)
f_cleanup response
f_cleanup other
$ECHO -e "$C_STR"

