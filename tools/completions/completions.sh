#!/bin/bash

case $- in *i*) echo "DO NOT SOURCE"; return esac

# need this
shopt -s interactive_comments

# variables

ERRCODES=( NORMAL FATAL ABORT CRITICAL ) 
EXITCODES=( OK FAIL ABORT FATAL1 FATAL2 ) # set by exit
TMPLOG=$(mktemp)
TRUENAME="completions.sh"
GXRMSRCDIR="$(dirname $BASH_SOURCE)"
GXRMSRC="$GXRMSRCDIR/scripts"
GXRMTGT="$HOME/.bash_completion"
GXRM_BEGIN="#####GXRM-ENTRY-STAMP#########"
GXRM_END="${GXRM_BEGIN}END#########"
GXRM_STAMP="####SCRIPT[SRC=${SCRIPT: 0:7} POS=${POS: 0:3} LINES=${LNS: 0:3}]####"
GXRM_STEND="###########SCRIPT#####END#####POINT!###########"
AUTHOR_EMAIL="mailto:osirisgothra@hotmail.com"
AUTHOR_WEBSITE="http://www.github.com/osirisgothra"

# functions

function begin() 
{
	echo $GXRM_BEGIN >> $TGT
}
function end()
{
	echo $GXRM_END >> $TGT
}
function stampscript()
{
	declare -g LASTACT="$1"
	case $1 in
		INIT) printf "initializing..."
			declare -gi LNS=0 POS=0
			declare -g SCRIPT="(nil)"
			if [[ -r $TGT ]]; then
				printf "ok!\n"				
			else
				printf "$TGT does not exist... creating it now: "
				if ! touch $TGT; then
					printf "\n$TGT could not be created!!! \n--- aborting script advised (check permissions!)\n"
					printf "continue (and enable debugging)??: "
					if ynchoice; then	
						return 1
					else			
						exit 1
					fi
				fi
				echo "ok"				
			fi
			return 0;;	
		START) 	eval "echo \"$GXRM_STAMP\"" >> $TGT;;
		  END)  eval "echo \"$GXRM_STEND\"" >> $TGT;;
      		 BODY)  cat "$SCRIPT" >> $TGT;;
	       ACTION)  if [[ -r "$2" ]]; then
	       			if [[ $LASTACT == INIT ]]; then
	       				printf "starting merge process  :"
	       			else
	       				printf "continuing merge process:"
	       			
				SCRIPT="$2"
				let POS++
				LNS=$(grep -c '.*' --line-regexp "$2")
				printf "#$POS - $2: ($LNS lines) tagging....."
				if stamp_script START && stamp_script BODY && stamp_script END; then
					printf "ok!\n"
				else
					printf "failed!\n"
					case $LASTACT in
						BODY)
								printf "cause: BODY TAG FAILURE\n"
								printf "action: file not found or can not be accessed, please check file location/existence/permissions (note any messages)\n"
								printf "action: please notify author if files are missing from distribution and check the MANIFEST!\n"					
								;;&
						BODY|START|END)	printf "cause: writing $LASTACT tag failed\n
								printf "action: check script for problems, hard disk for free space, and sys logs for outside errors.\n"
								 ;;& 
						*) 		printf "if no other actions/causes listed above, please notify author at once after having ruled out any local problems of cause!\n"
								printf "$AUTHOR_EMAIL\n"
								printf "$AUTHOR_WEBSITE\n"
								echo
								echo "The Script Will Now Enter Debug/Trace Mode [if you continue]!"
								echo "[PRESS ANY KEY TO CONTINUE, OR CTRL+C TO EXIT, OR CTRL+Z TO SUSPEND]"								
								read -sn1
								echo "setting traps.."
								trap 'echo "trace-AV=$(declare -p BASH_ARGV) AC=$BASH_ARGC BC=$BASH_COMMAND"' DEBUG RETURN ERR SIGCHLD SIGTSTP
								echo "turning on trace/debug/extdebug..."								
								set -x -v -E -T
								shopt -s extdebug								
								return 1
								;;
					esac
				fi																
			else
				echo "skipping $2, unreadable - check for accessibility!!"
				return 1;
			fi
			# fall throughs here mean no errors!
			return 0;						
			
		    *)  echo "Warning!!! Passed invalid argument $FUNCNAME $* - press any key to proceed (debugging now enabled)"
			set -x -v -E -T; shopt -s extdebug; read -sn1 NIL; trap 'echo "$BASH_SOURCE - $BASH_COMMAND - $BASH_ARGC $BASH_ARGV - $_"' DEBUG ERR RETURN SIGCHLD SIGTSTP
			;;
		
	esac
	# fall through here means to give back current code
	return $?
}

function ynchoice() 
{ 
	REPLY=""; while [[ ! $REPLY =~ [yn] ]]; do read -sn1; done; case $REPLY in y) return 0;; n) return 1;; esac; 
}

# init


if [[ ! -r scripts ]] || [[ ! -r $TRUENAME ]]; then cd $(dirname $BASH_SOURCE); fi
if ! touch $TMPLOG || [[ ! -w $TMPLOG ]]; then echo "can't write tempfile, check mktemp, failing (inform admin!)"; fi

# verify we are in the right place
if [[ -r completions.sh ]] && [[ -d scripts ]] && [[ -r ../../MANIFEST ]]; then
	echo "file structure in tact, checking permissions..."
	if [[ -r ~/.bash_completion ]]; then
		echo "Your ~/.bash_completion is about to be modified (appended), is this okay?"
		if ynchoice; then
			GO=1
			declare -g NEWFILE=0
		else
			GO=0
		fi
	else
		echo "~/.bash_completion does not exist, will create it anew..."
		declare -g NEWFILE=1		
		GO=1
	fi	
	if -w ~/; then
		echo "home is writable, starting..."
		if [[ $GO -eq 1 ]]; then		
			echo "merging completions..."
			if [[ $NEWFILE -eq 0 ]]; then
				echo "marking the point of insertion (for later uninstall, if needed)..."
			else
				echo "marking header of the new file..."
			fi
			echo $GXREGMARK_BEGIN >> $TGT
			echo "defering operation to action subroutine-loop..."
			for i in scripts/*.sh; do
				[[ -r "$i" ]] && stamp_script ACTION "$i" || { echo "skipped ghost script: $i"; true; }
				if [[ $? -ne 0 ]]; then
					echo "error detected, logged offender to $TMPLOG (no further messages will be posted to console by the main loop)"
					echo "LOGENTRY $(date) : offender $i, target = $TGT, pos = $POS, lns = $LNS, lastact = $LASTACT, lastscript = $SCRIPT, user = $USER($UID) groupl = $(groups), uname = $(uname -a)" >> $TMPLOG					
				fi
			done
			echo "...completed (use completion.sh --uninstall to rid yourself of these completions later!)"
		else
			echo "operation aborted by user (1)"
			(exit 1) # set errcode to 1
		fi
	else
		echo "fatal error: home (~/) is not writable! check that \$HOME == ~/ == $HOME, and they are writable and owned by you!"
		(exit 2) # set errorcode to 2
	fi
else
	echo "fatal error: cannot get to directory where completions.sh belongs (in the gxbase/tools/completions/ distribution location usually)"
	echo "probable cause: incomplete kit -- missing files (check MANIFEST),  misplaced script, bad permissions."
	echo "note: you shouldn't need to be root to use this tool, but if you are CERTAIN it is the problem, you can try.... at your own risk!"
	echo "abort (code 3)"
	(exit 3) # code to 3 (see header about this)
fi
	
		
			
			
	
	

