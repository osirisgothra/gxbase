#!/bin/bash

# {{{ Modelines 
# vim:ft=sh:showmode:ts=3:sw=3:tw=120:noautoindent:nowrap:tags=/etc/bash_ext_tags 
# vim:foldclose=all:foldmethod=marker:foldenable:cc=100:fml=0:tw=9999:fdc=4
# }}}
# {{{ SPECIAL NOTES
# 1. To use tags, make sure you compile the tags file with the makebashtags command from this script
# 2. If you change your tags location, make sure you update the modeline (line 8) with the location
#    which is by default, /etc/bash_ext_tags, for simplicity (though you may not have access to that
# 	  if you aren't a admin.
# 3. This document is best viewed with the following editors:
#		*1: vim (most in-doc features wont work without using vim)
#      2: komodo
#      3: kate         4: gedit     5: text editors that support vi emulation
#    * unless you use vim, this file will be much harder to keep track of since the fold system
#      is already programmatically set up for you, along with the vim options you'll need. Other
#      editors do not support such inline things and will require work on your part. I reccomend
#      you use vim with the YCM, Syntastic, xxx-support (perl-support, bash-support, etc) and the
#      Unite plugin, all under the control of the Vundle plugin (or vam, if you'd rather).
#      I DO NOT SUGGEST: lh- plugins <- especially lh-brackets, it seems to mess up everything
#                        however, the xxx-support plugins dulicate the lh- plugins functioning
#                        (better) anyway. For viewing the result of using ANSI codes, you may
#                        want the AnsiEsc plugin as well. And make sure you enable the Manpage 
#                        support too!
# 4) if you downloaded this, it should have come from: http://gitorious.org/+Paradisim
#    or http://github.com/osirisgothra. It is packaged with the 'gxbase' collection. Check
#    there or use the git://github.com/osirisgothra/gxbase repository to get the latest one.
# 5) USE AT OWN RISK, you are not a little child, you should know what I mean by that. 
#    (not intended for children, if you are wondering)
# }}}

#{{{ PREINIT

	# {{{ Interactive Mode Check & EMS Provisions
case $- in
    *i*)
		 	TTY=$(tty)
			# we ARE in interactive mode 
			case $TTY in
				/dev/tty*)
					echo "Starting in URGENT mode (console), extensions disabled."
					echo "Reading skeleton bashrc, if it exists..."
					if test -r /etc/skel/.bashrc; then source $_; fi
					if test -r ~/.bashrc-console; then source $_; fi
					return;;
				*)
					# don't install it if we don't have the kbhit program!
					if which kbhit &> /dev/null; then
						echo "[1mPress [E] For Emergency Mode During Startup.[0m"
						#{{{ STARTUP TRAP FUNCTIONS
						# {{{    _startup_trap() 
						function _startup_trap()
						{
						#	echo "ARGS: c= $BASH_ARGC V=${BASH_ARGV[@]}"
							local ems_rc="/tmp/bashrc-emergency"
							kbhit
							if [[ $? -eq 69 ]]; then
								echo "Startup Halting (Emergency Mode Triggered)"
								echo " - You can exit Emergency mode by [1mexit[0ming this subshell at any time."
								echo " - When exiting, your normal shell will continue starting up."
								echo " - Type [1mhardexit[0m to completely exit the shell without resuming."
								echo " - The system's default bashrc will be used here (/etc/skel/.bashrc)."
								echo " - If no default bashrc is found, none will be used (--norc)."
								if [[ -r /etc/skel/.bashrc ]]; then
									cat /etc/skel/.bashrc > /tmp/bashrc-emergency 
									chmod 777 /tmp/bashrc-emergency
									echo "alias hardexit='exit 122'" >> /tmp/bashrc-emergency
									bash --rcfile /tmp/bashrc-emergency
								else
									bash --norc
								fi
								if [[ $? -ne 122 ]]; then
									echo "Returning to shell [3 second pause]"
									#TODO: move to a variable if changes are needed or deemed worthy of a var.
									rm /tmp/bashrc-emergency
									sleep 3			
								else
									echo "Hard-Exit Request, Terminating This Session!"
									sleep 1
									rm /tmp/bashrc-emergency 
									exit $?
								fi 
							fi
						}
						#}}}
						#}}}
						trap _startup_trap DEBUG		
					else
						echo "notice: kbhit is missing, emergency mode will not be available"
					fi 
					;;
			esac
			# end of interactive mode case handling
			;;
      *) 
			# do no special handling, but process .bashrcni if it is there
			echo "Bash Spawning In NonInteractive Mode [level=$SHLVL args=$* callers=${BASH_SOURCE[@]} "
			test -r ~/.bashrc-noninteractive && source $_
			return;;
esac

#}}}
	# {{{ 	Cache [ faststart(rm) loading ]
	# TODO: use *.environment files to reload additional shells in the same term api, if nothing
	# in bashrc has been touched since their creation
	# TODO: otherwise, flag for rebuilding the environment files (in the background) AFTER the
	#       terminal program (not the shell) exits. This should be non-interactive and disconnected
	# 		  from any TTY or PTS, in otherwords, forked as a daemon
# }}}
		# {{{ RESET / CLEAR / UNSET VARIABLES

		export PS1=""
		unset INGIT GITDIR OLDWD GITSPECIAL &> /dev/null
		declare -g INGIT GITDIR OLDWD GITSPECIAL

		# }}}
#{{{ CREATE REQUIRED DIRECTORIES
	function mkdirif() { [[ ! -r $1 ]] && mkdir --parents "$1"; }
	mkdirif ~/.config/bashrc/flags
	mkdirif ~/.config/bashrc/ps1colors
	mkdirif ~/.config/bashrc/environment
#}}}
# {{{ Code Mechanisms

# {{{ Hash Commands
	if [[ -r ~/.config/bashrc/flags/USE_PREHASH ]]; then
		echo "Pre-Loading hashes... (this may take a second)"
		for each in $(cat ~/.bashrc-hash | grep -o "^\s*[^#]*"); do
			# must be:
			# executable (-x)  a file (-f) readable (-r)
			# not a directory (! -d) <- since some files are symlinks to directories!
			eval '[[ '{-x,-f,-r,\!\ -d}' $each ]] &&' hash -p "$each" `basename $each`
		done
	fi

# }}}
# {{{ Environment Locality

# {{{ Explanation
#
#	Environment Locality 
#
#  This .bashrc uses a mechanism simmilar to Windows NT's SETLOCAL and ENDLOCAL command processor
#  script directives. Like their counterparts, they save and restore the environment and work on
#  a completely independant basis. They do not affect other processes, scripts, or sessions running.
#  To achieve this in WINDOWS, memory sacrafice was needed, and not a problem since the environment
#  rarely had more than a handful of variables in it. On Unix-Based systems, under bash, the
#  environment is far greater in size and would consume much memory. Furthermore, with NESTED
#  states being saved, it becomes a particular problem. Implementing delta compression or other
#  complicated aglorithims to minimize memory usage could be added  but at the expense of time. To
#  solve this problem, the files are written to disk instead. The problem then becomes clobbering
#  of the state files used. To solve that problem, we use a per-user config directory, and create
#  a new session ID each time bash is started for that session only. The ID is a guid number and
#  so the chance of clobbering is next to nil unless you have a system where billions of people are
#  using the same account at the same time, which is highly unlikely (like close to the world's 
#  population count!). So this is 99.99999999% fool proof which is better than even the memory
#  model used by Microsoft, which is only about 75% fool proof, give or take.

#  The states are NESTED, that means you can use 'setlocal' and 'endlocal' as many times within one
#  another without worry. There's no limit to the number of states you can have. What that really
#  means is that you can have as many states as your memory in your computer allows, and the CPU
#  is able to recognize integers. My computer can do numbers up into the 9,000,000 trillions, i am
#  not even sure what that number is really called, it was too long to print out. It is more likely
#  to run out of hard drive space before # of states, like i said, unless you have the world's 
#  population all using the same script and in the same instance, that is they are all connected by
#  the one script -- highly unlikely (and if it IS likely, you wont be using BASH I sure hope!).
#
#  Ramble ramble... the differences are clear however, variables that are declared are DELETED.
#
#  When switching states so dont expect this:
#
#  MYVAR=1      # environment contains only MYVAR
#  setlocal
#  readonly MYVAR # wrong! can't set readonly variables in setlocal
#  MYVAR=2      # local value for MYVAR
#  MYVARS_LOCALVALUE=$MYVAR   # another 'local' value, but wasn't even defined before now
#  endlocal     # environment restored
#  echo $MYVARS_LOCALVALUE    # WRONG, it has been deleted, even though it didnt exist!
#
#  To allow even variables that didnt exist before would breach the idea. Since some scripts rely
#  on variables not existing, including this one, you should never expect undeclared variables to
#  exist. Also, a variable will retain it's attributes as well.
#
#  The Catch
#
#  Because BASH has a 'readonly' builtin, you can NOT use it when inside setlocal, which would cause
#  it to malfunction. readonly is only enabled outside the last setlocal block, which is the GLOBAL
#  scope. Do not setlocal without endlocal and assume you can use readonly again!

#
#
# }}}

# check for BASH_SESSION_ID [-v]ariable and if it's not[!] there...
if [[ ! -v BASH_SESSION_ID ]]; then
	# they only get set one time per session, (re)sourcing does NOT affect this (read explanation)
	declare -i SETLOCALSTACK=0
	readonly BASH_SESSION_ID="$(uuidgen)"
	readonly SETLOCAL_SESSION_DIR=~/.config/bashrc/setlocalstack/$BASH_SESSION_ID
else
	echo "[0;3mRefreshing Session [4m${BASH_SESSION_ID//\[\{\}\]\-}[0m..."	
fi

[[ -d $SETLOCALDIR ]] || mkdir --parents $SETLOCAL_SESSION_DIR

function setlocal()
{	
	((SETLOCALSTACK++))
	if declare -f readonly &> /dev/null; then
		true "don't need to do anything - readonly state persists"
 	else
		function readonly()
		{
			echo "Warning: in stack $SETLOCALSTACK, cannot set a readonly ($*) -- Variable Declaration IGNORED"
		}
	fi
	declare > $SETLOCAL_SESSION_DIR/stack.$SETLOCALSTACK
}
function endlocal()
{
	[[ $SETLOCALSTACK -eq 0 ]] && {	echo "${BASH_SOURCE[@]}: endlocal: stack is empty (session $BASH_SESSION_ID)"; return 1; }
	
	eval `declare | sed 's/declare/unset/'`  
	 
	source $SETLOCAL_SESSION_DIR/stack.$SETLOCALSTACK
	((SETLOCALSTACK--))
	# re-enable readonly if we are at stack level 0
	[[ $SETLOCALSTACK -eq 0 ]] && unset -f readonly
}
# }}}

# }}}

# }}}
# {{{ SHOPT

shopt -s checkwinsize
shopt -s histappend 
shopt -s extglob
shopt -u nullglob

# }}}
# {{{ SHOPT -O (aka set)

# SETS

# .debug-bashrc causes debugging to happen
[[ -r ~/.debug-bashrc ]] && set -x || set +x

# OSHOPT (shopt -o)
shopt -o -u histexpand

	

# }}}
# {{{ ENVIRONMENT VARIABLES

#{{{ CONFIGURATION DIRS
	export BCROOT=~/.config/bashrc
	export -a BASHCFG=( 
		env: $BCROOT/environment/
		flag: $BCROOT/flags/
		dev: $BCROOT/dev/
		ps: $BCROOT/ps1colors/
		lo-stack: $BCROOT/setlocalstack/ 
		shells: $BCROOT/shells/
		)

#}}}
# {{{ BACKUP BASHRC CONTROLS

# force backups (reccommened)
export BASHRC_BACKUPS=ON

# }}}
# {{{ FIND_IN_EXTRAS Pathdata

FIND_IN_EXTRAS=".:/etc:/etc/init:/etc/default:/etc/init.d:/etc/bash_completion.d:/gxbase/res:/gxbase/bin:/gxbase:~/:~/.config:~/.local" 
FIND_IN_EXTRAS+=":/etc/dictd"
FIND_IN_EXTRAS+=":/etc/alternatives"

# }}}
# {{{ HISTORY 
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=200000
# }}}
# {{{ PROMPT COLORIZATION VARIABLES

# {{{ Explanation
# Homebrew "K" Factors (using helpers example: 'kofs -16' == "declare -ig Kofs=$[ $Kofs - 16 ]"
# do NOT forget that presets need to be separated by whitespace, NOT by $IFS!!
# factorstore  (presets are [NAME]="RRR:GGG:BBB:rgb" where RRR,GGG,BBB are 3-digit numbers 000 to 255 (MUST BE 3 DIGITS!!) }}}

#depreciated: see loadprs()
#declare -gA Kpresets=([DirtyRainbow]="032:032:003:rgb" [CraterSmoke]="222:237:100:rgb")

declare -gi Kmul=222
declare -gi Korf=237
declare -gi Kofs=100

# }}}
# {{{ TEMP / CACHE 

declare -gx ZOLDWD=$PWD

if touch /var/tmp; then
	GTMP=/var/tmp
elif touch /tmp; then
	GTMP=/tmp
elif touch ~/.cache; then
	GTMP=~/.cache
elif touch ~/; then
	# avoid if you can!
	echo "warning: no other writable location than home, using it reluctantly for cache/temp (check /tmp and /var/tmp)"
	GTMP=~/
else
	# now we are in trouble!
	echo "fatal: cant find any writable locations for tempfiles!"
	while (! touch $GTMP); do
	
		echo "Enter the name of a writable location for tempfiles:"
		read GTMP
	
	done	
	
	
fi

# set this to a project other than this if you want, this is safe though
# IMPORTANT: if you dont use user-specific/group-specific dirs per user, you might run into permission denied and
# security problems! This string guarentees that doesn't happen:
export GITDSITE=${GTMP}/gitdummy_$(id -g)_$UID

# so we dont have to keep running /usr/bin/tty
if tty -s; then
	# TODO: investigate that the TTY lock can be altered after an exec(2) or fork(2)
	declare -gxr TTY=$(tty)
	declare -nx OTTY=TTY
	declare -gx ETTY=/dev/fd/2
else
	declare -gx TTY=NONE
	declare -gx ETTY=~/.errors_bashrun_$(date +"%H%M%S_%m%d%y")_stderr
	declare -gx OTTY=${ETTY/err/out}
fi

#}}}
# {{{ 3RD-PARTY PROGRAM ENVIRONMENT VARIABLES (ie, perl, tee, grep, etc)

# {{{ Midnight Commander
export MC_SKIN="modarin256-defbg"
# }}}

# }}}
# {{{ GLOBALS

# {{{ Common Response Variables
YES_STR="Yeah"
NO_STR="Naw"
IGNORE_STR="Ignore"
ABORT_STR="Stop"
OK_STR="Allrighty"
RETRY_STR="Retry"
CANCEL_STR="Cancel"
SKIP_STR="Skip"
ABANDON_STR="Abandon"
DEFER_STR="Do Later"
SUSPEND_STR="Suspend"
RESUME_STR="Resume"
SVCSTART_STR="Start"
SVCSTOP_STR="Stop"
ACT_RE_STR="Re-"
ACT_AGAIN_STR="Again"
ACT_ALWAYS_STR="From Now On"
ACT_NEVER_STR="Never Again"
ACT_RESET_DEFAULTS_STR="Restore Defaults"
# }}}
# {{{ /environment Load Files
SUDOIZED_FILE=~/.config/bashrc/environment/sudoized_command_list.rc
COPROC_FILE=~/.config/bashrc/environment/coproc_command_list.rc
# }}}
# {{{ Keyboard Codes
# these are protected to guarentee safe function of scripts/functions that rely on them
# and since they could pose a security threat if redefined, i have made them this way. 
# Your scripts should check to see if these values are readonly, which is a good way to 
# ensure they are still valid. There is a hash at the end you can use to calculate the
# keystrokes for valididity.
if [[ ! -v Anchor ]]; then
	readonly Anchor='[s' Return='[u'
	readonly Home='[H'   End='[F'
	readonly Up='[A'			Left='[D'
	readonly Down='[B'   Right='[C'
	readonly PgDn='[6'  PgUp='[5'
	readonly NewLine='
	'
	# Function Keys (F1-F12)
	# use like this: use F1: ${F[1]} -- kind of clunky but good for dynamic use, for static use see
	# below. You can also add more of your own if you wish to have more than just 12 F-keys assigned.
	# TODO: this could probably be done better, but works for most purposes -- complain to me if it doesn't
	if [[ $TERM == "linux" ]]; then
		# assume console 
		# uses \e[[LTR codes for F1-F5  \e[#~ codes start at F6
		readonly -a F=("nil" "[[A" "[[B" "[[C" "[[D" "[[E~" "[17~" "[18~" "[19~" "[20~" "[21~" "[22~" "[24~")
	else
		# assume GUI
		# uses \e[OLTR codes (starting at letter "O") for F1-F4, \e[#~ codes start at F5*
		# *The F5 is assigned '15', the F6-F12 codes are identical to the console codes
		readonly -a F=("nil" "OP" "OQ" "OR" "OS" "[15~" "[17~" "[18~" "[19~" "[20~" "[21~" "[22~" "[24~")
	fi
	# this makes references for easier use ( $F1 instead of ${F[1]} ) it is also dynamically created so 
	# you will not have to change anything here if you add more F-keys above. This is the reasoning
	# for the slight extra (double) evaluation, since you never need to touch it, should not be a problem
	# to maintain.
	for key in `eval echo {1..$(( ${#F[@]} - 1 ))}`; do declare -rn F$key=F[$key]; done
	readonly Ins="[2~"
	readonly Del="[3~"
	# Backspace (usually will be )
	readonly Bs=""
fi
# }}}

# }}}
# }}}
# {{{ STANDARDIZED INIT CONTENT (original .bashrc stuff)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
color_prompt=""
if [[ "$force_color_prompt" ]]; then
	if [[ -x /usr/bin/tput ]]; then
		if tput setaf 1 >& /dev/null; then
			color_prompt=yes
		fi			
	fi
fi
if [ "$color_prompt" = yes ]; then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
[ -x /usr/bin/dircolors ] &&  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
# }}} 
# {{{ USER ALIASES

# {{{ Sudoized
echo -n "* Sudoized Commands: "
if [[ $UID -ne  0 ]] && groups | grep -q sudo; then
	if [[ -r $SUDOIZED_FILE ]]; then
		echo "[1;32mAvailable: [0m[s"
		mapfile SUDOIZED_COMMANDS < $SUDOIZED_FILE && len=${#SUDOIZED_COMMANDS[@]} || len=-1
		for ((i=0;i<len;i++)); do
			item=${SUDOIZED_COMMANDS[i]}
			item=${item: 0:-1}
			alias $item=sudo\ $item
			echo "[u[s$item[0K"
		done
		echo "[u$[len+1] item(s)[s[0K[u"
	else
		echo "[0;1mDisabled (type 'sudoize --help' for info)"
		function sudoize() 
		{ 
			local RV=$?; 
			if [[ $* == "--help" ]]; then 
				echo "Please place newline separated text list of commands to sudoize in:"
				echo "$SUDOIZED_FILE (type commands how you would on command line)" 
		  	fi 
			return $RV
		}
	fi	
elif [[ $UID -eq 0 ]]; then
	echo "Running as [1;31mroot[0m (highest admin account, no sudo needed!)"
else
	echo "[1;30mNot Available (not a member of sudo group)[0m"
fi

# }}}
# {{{ Coprocessed (back threaded)

function proc_co()
{
if [[ -r $COPROC_FILE ]]; then

	# had to use perl here, bash+grep+sed+awk took too much time on this one
	
	eval declare -a COPROC_CMDS=(`perl -we 'while (<>) { unless (/^\s*(#.*)?$/) { my @items=split; print " " if our $notfirst++; print "\"$items[0]\""; } }' $COPROC_FILE`)
	eval declare -a COPROC_KIND=(`perl -we 'while (<>) { unless (/^\s*(#.*)?$/) { my @items=split; print " " if our $notfirst++; print "\"$items[1]\""; } }' $COPROC_FILE`)
	len=${#COPROC_CMDS[@]}
	for ((i=0;i<len;i++)); do
		item=${COPROC_CMDS[i]}
		kind=${COPROC_KIND[i]}
		# debug: # echo -e "\tItem name,kind=$item,$kind"
		case $kind in
			owned) # run in background normally
				eval "function ${item}() { $item \"\$@\" & }"
				;;
			disowned) # run in background, but dont keep in job list
					eval  "function ${item}() { $item \"\$@\" & disown; }"
				;;
			silent) # run in background, without any output
				eval "function ${item}() { $item \"\$@\" > /dev/null 2>&1 & }"
				;;
			ignored) # run in background, removed from joblist, and no output (aka pseudo-daemonize)
				eval "function ${item}() { $item \"\$@\" > /dev/null 2>&1 & disown; }"
				;;
			suspended|delayed|timed)
				echo "warning: the $kind is reserved for future use and has not been yet developed"
				;;
			*)
				echo "warning: $kind is not a valid coproc behavior kind (see the documentation or .bashrc script (lines $[ $LINENO - 12 ] - $LINENO) for further details)"
				sleep 0.25 # so the user sees it (the motd can have clear marks in it, after all)
				;;
		esac 
	done			
	echo -ne "* $len Coprocessor Commands Loaded\n"
fi
}
proc_co

# }}}
#:{{{ Hardcoded Conditional
if [[ $TTY != NONE ]]; then
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto -P'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias lb='source ~/.bashrc'
	alias ls='ls -lh --color'
	alias du='du -h --max-depth=1'
	alias df='df -h --total `lsblk | grep -Po "(?<=part )/\S*" | tr "\n" " "` | colorit'
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'
	if which notify-send &>/dev/null; then
		alias alert='sudo notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
	else
		alias alert='sudo wall "$*"'
	fi
	if (groups | grep sudo -q) || [[ $UID -eq 0 ]]; then
		if alias sudo &>/dev/null; then
			unalias sudo
		fi
	else
		alias sudo='echo "Sudo unavailable (blocking request to prevent logging this attempt -- use unsudo command to override this behavior)" '	
		alias unsudo='if alias sudo &>/dev/null; then unalias sudo; echo "sudo block removed"; else echo "no sudo block installed!"; fi'
	fi
	if [ -f ~/.bash_aliases ]; then
		 . ~/.bash_aliases
	fi
else
	true
	# dont do any aliases since we have not a TTY, which means no keyboard input, which means no aliases either
fi

# }}}
# {{{ BASH COMPLETION

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if shopt -oq posix; then
	echo "Warning: posix-compatibility mode has been enabled, please check your startup scripts."
else
  if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
  elif [[ -f "/etc/bash_completion" ]]; then
    source "/etc/bash_completion"
  fi
fi

# }}}
# {{{ FUNCTIONS
 
# {{{ Super Builtins - Ones that do better than their builtin counterparts (but still use them and/or call them)
# {{{    alias
function alias()
{
	if [[ $1 =~ (/|--?)(padd|premove) ]]; then
		case ${1##\/\-} in
			padd)
				alias_add "$@"
				return $?
				;;
			premove)
				alias_remove "$@"
				return $?
				;;
		esac
	fi
	# default behavior (quotation is essential!)
	builtin alias "$@"
	return $?				
}
# }}}
# {{{     cd 
function cd() 
{
	# {{{ Argument Explanation
	# Purpose: change to another directory implementing virtual ones along the way
	#    Args: [cd options] [new location file/virtual location]  
	# }}}
	# {{{ Empty Args Handler (calls self with ".", and returns that code)		
	if [[ -z $1 ]]; then
		command cd .
		return $?
	fi
	# }}} 
	# {{{ Environment
	#setlocal  # saves the environment state and pushes it into a file to be restored (does not consume memory)
	# {{{ Init
	#{{{ Local Functions for cd()
	# {{{ decho() - debug echo
	function decho()
	{
		builtin echo "$@" > $(tty)
	}

	#}}}
	#{{{ funtion cd::echo()
	function echo() 
	{ 	  	
		#{{{ log echo [disabled]: builtin echo "$@" &>> /var/log/gts_bashlog.log 
		#}}}
		#{{{ regular echo (disabled): builtin echo "$@"  
		#}}} 
		#{{{ Place echo command action in here (or 'true' to emulate nothing)
		true "$@"
		#}}}
		return $?; 
	}
	#}}}
	#}}}
	#}}}
	# }}}

# {{{ @FILE Integration
	if [[ ${1: 0:1} == "@" ]]; then
		decho "guessing a switching to $1"
		if [[ $1 =~ @@.+ ]]; then
			PUSHMODE=1
			TGT=${1: 2}
		elif [[ $1 =~ @.+ ]]; then
	    		TGT=${1: 1}
			PUSHMODE=0
		else
			# must be a single @ sign, maybe a directory name, pass on down..
			PUSHMODE=2
		fi
		if [[ $PUSHMODE != 2 ]]; then
			decho "Target: $TGT"
			if locate -n1 "$TGT" &> /dev/null; then
				local LOC=`menu -vert $(locate "$TGT") '$RETRY_STR' '$CANCEL_STR'`
				case "$LOC" in						
					"$STR_RETRY")
						decho -e "Attempting: $STR_RETRY ... (re-entering loop)"
						cd "$@"
						[[ $? -eq 0 ]] && return $(cd_cleanup)
						decho "Failed Retry, Aborting"
						cd_cleanup "$STR_RETRY" "$LOC"
						return $?
						;;
					"$CANCEL_STR")
						decho -e "Cancelled!"
						cd_cleanup "$CANCEL_STR" "$LOC"
						return $?
						;;			
				esac
				
				decho -ne "Best Guess: $LOC"

				if [[ -d $LOC ]]; then
					JMPLOC=$LOC
					decho " (directory)"
				else
					JMPLOC=`dirname $LOC`
					JMPLOC=`realpath $JMPLOC`			
					decho " (directory + file)"
					#TODO: possible handling of a file shell
					if navshell "$LOC"; then
						return 0
					else
						decho "File $(basename $LOC) can't be navigated into, using it's parent directory: $JMPLOC"
					fi
				fi
				[[ $PUSHMODE -eq 1 ]] && pushd . &> /dev/null							
				if builtin cd "$JMPLOC"; then
					decho "Jump Ok"
					# delegate recursive call to update prompts (PS1/2)
					cd .
					return 0;
				else
					echo "Error ($?): $JMPLOC Inpenetrable, Passing Arguments Down The Line..."
				fi
			else
				echo "Info: $TGT - no targets, handling $0 $*..."
			fi
		fi
	fi


# }}}
#{{{ PERLCONSOLE integration
	if [[ $PERLCONSOLE_USESPECIALDIR -eq 1 ]]; then
		if [[ `realpath -s $* 2>&1` == "/perl-console" ]]; then
			perlconsole
			echo "poping back to $PWD"
			return 0
		fi
	fi
			
#}}}
	#{{{ APTSH Integration 
	# Special Directory Handling: aptsh in a fake "/apt" (can exist too)  	
   if [[ -v APTSH_USESPECIALDIR ]] && [[ "$(realpath -s $* 2>&1)" == "/apt" ]]; then
		# allow appropriate re-entry after crash
		echo "$PWD" > /tmp/lastdir.aptsh
		xtitle "/apt (APT/DPKG Shell Interface)"
		sudo aptsh
		local -i RETV=$?
		if [[ $RETV == 12 ]]; then
			exit
		elif [[ $RETV != 0 ]]; then
			cd /apt 
		fi
		local NEXTDIR="$(cat /tmp/lastdir.aptsh)"		
		if [[ ! -z $NEXTDIR ]]; then
			# start from here in order to make the "cd .." and "cd ../[dirs]" 
		  # work as if comming from a real /apt (this is what the user expects)	
			cd /tmp
			cd "$NEXTDIR"
		else			
			echo "Notice: exited aptsh ungracefully, returning to previous directory!"
			# (... which we are already in:)
		fi		
		return 0
				
	fi
	#}}}
	#{{{ GITSH integration (Must be LAST)
  	#{{{ Special Directory Handling: git root, git subtree, git submodule tree, etc

	if [[ $GITDIR ]]; then
		OLDWD=$GITDIR
	else
		OLDWD=NONE
	fi
	
	echo "LAST GIT DIR: $OLDWD"

	if builtin cd "$@" && RETCODE=$?; then
		echo "NEWWD: $PWD"
		echo "DIFWD: ${PWD#$OLDWD}"
		if [[ "$OLDWD" == "NONE" ]] || [[ "$PWD" == "${PWD#$OLDWD}" ]]; then		
			echo "(changed into new parent)"
			if [[ -d .git ]] || parentshave .git; then
				echo "(git dir detected)"
				GITDIR="${PWD}"
				INGIT=YES
			else
				echo "(git dir, not detected -- plain)"
				INGIT=NO
				unset GITDIR
			fi
		else
			echo "(same root, no changes)"
			# in a subdir of same root, keep current mode
			:
		fi
	else
		# change failed, will not change state
		:
	fi	
	#}}}
	#{{{ Handle Git Status, xtitle, and PS1/PS2 COLOR
	case $INGIT in

		YES)
			#{{{ Set XTERM or XTERM-Compatible Title (*), and update the Prompts, LOAD .bashrc-git's stuff
			xtitle "$PWD (GIT Repository)"
			PS1=$PS1_GIT
			PS2=$PS2_GIT
			GITSPECIAL=SET
			[[ $OLDGS != $INGIT ]] && source ~/.bashrc-git
			;;
			#}}}
		NO)			
			#{{{ Set XTERM or XTERM-Compatible Title (turn it on in your favorite term)
			XTPWD="$PWD "
			if parentshave .svn; then
				XTPWD+="(SubVersion [svn] Tree Branch)"
			elif parentshave .git; then
				XTPWD+="(Git Repository Child)"
			elif parentshave .hg; then
				XTPWD+="(Mercurial [hg] Tree Branch)"
			elif parentshave configure || parentshave configure.in || parentshave Makefile || parentshave automake; then
				XTPWD+="(Generic SourceCode Tree)"
			elif parentshave vim-addons; then
				XTPWD+="(User's VIM Tree)"
			elif parentshave mswin.vim; then
				XTPWD+="(System's VIM Tree)"
			fi			
			
			# because no echo or silent processing in effect /dev/null 
			xtitle "$XTPWD" > $(tty)
			#}}}
			#{{{ Set Prompt Colors
			
			if [[ $PWD != ${HOME} ]]; then			
		
			#{{{ Set Colors For Normal Directories
			# dont use global or exported!
			local -i XTCOLOR=${#PWD}
			# hard to read colors are not used
			case $XTCOLOR in
				0|4|8|16|17|18|18|20|21|22|23|24)
					((XTCOLOR+=24))
					;;
			esac
			PS1='\[[38;5;'${XTCOLOR}'m\]'"$PS1_NORMAL"'\[[0m\]'
			PS2='\[[38;5;'${XTCOLOR}'m\]'"$PS2_NORMAL"'\[[0m\]'

			#}}}	
			
			else

				#{{{ Set "Colorized SemiRandom Colors" For Your HOME Folder
				# see Korf/ofs/mul for explanation in /VARIABLES/

				[[ $UID -eq 0 ]] && ROOTUSER="#" || ROOTUSER="$"

				#TODO: translate original prompt instead of using a static one
				declare HOMEPROMPT="$USER@$HOSTNAME $PWD ${ROOTUSER}"
				declare HOMEPROMPT_RB='\[[0m\]'
				declare HOMEPROMPT_RB_P2='\[[0m\]'
				declare -i m=0

				for ((k=0;k<${#HOMEPROMPT};k++)); do
					
					# we could have used "${RANDOM: 0:3}" but the prompt would change every time
					# and, there would be no rainbow effect, that is intended (its ugly trust me)
					HOMEPROMPT_RB+='\['"[38;5;$(( (k + $Kofs) * $Kmul | $Korf ))m"'\]'"${HOMEPROMPT: $k:1}"

					# let PS2 get in on the action, while it's able to
					if [[ $k -lt ${#PS2_NORMAL} ]]; then
						HOMEPROMPT_RB_P2+="\[[38;5;$(( (k + $Kofs) * $Kmul | $Korf ))m\]${PS2_NORMAL: $k:1}"
					fi

				done

				# "colorized" prompt for home folder!
				PS1="${HOMEPROMPT_RB}\[[0m\] "
			   PS2="${HOMEPROMPT_RB_P2}\[[0m\] "

				#}}}
			
			fi
			
			#}}}
			#{{{ Set GIT Mode Off, and Reload .bash-git so it can unload it's stuff itself (must be gxbase patched one)
			GITSPECIAL=UNSET
			[[ $OLDGS != $INGIT ]] && source ~/.bashrc-git
				#}}}
			;;
	esac
	OLDGS=$INGIT
	#}}}
	# }}}

	#{{{ cleanup any resources used * TODO: remove after setlocal is completed	
	unset -f echo
	unset -f decho
	#}}}
	#endlocal # restores the environment state, from last stack push
	return $RETCODE
}
#}}}
# {{{    coproc
function coproc()
{
	builtin coproc "$@" &> /dev/null
	LAST_COPROC_PID=`jobs -p | grep -Po '[0-9]{3,32}'`
	# can't disown until jobs completes
	# disown w/o arguments disowns last coproc/bg/stopped command
	disown
	echo "Started `which $*` : $LAST_COPROC_PID [detached]"
}
# }}}
# }}}
# {{{ Super Commands - Like Super BUiltins, Except for the Commands Themselves (usually faster or smarter than originals, including them)
#{# {{{    cat() [cat args] [filename] : colorizing cat via /etc/dictd/colorit.conf 
function colorcat()
{	
	command cat "$@" | colorit 
}
# }}}
#{{{     xtitle() [xtitle commands] : run xtitle conditionally
function xtitle()
{
	if [[ $TTY =~ ^/dev/tty\d+$ ]]; then
		# TODO: add support for byobu(screen,tmux), and other shell containers
		# silent, do nothing
		true
	# use only if a virtual tty master/slave is used
	# since ubuntu uses /dev/pts/[number] and bsd uses /dev/pty[number]
	# others might use /dev/pts[number] or a mix of the above, we must
	# only check for 1) the /dev dir is parent  2) the device or device's dir starts with 'pt'
	elif [[ $TTY =~ ^/dev/\S*pt.+$ ]]; then
		# don't use if it's not installed (package must exist or a script could be used also)
		if which xtitle &>/dev/null; then
			command xtitle "$@"
		else 
			true
		fi
	else
		# do nothing, this one will always return true like it succeeded
		# TODO: add any other TTY recognition for bsd, redhat, slackware, etc
		true
	fi				
}
#}}}
function setvarif()
{
	#0 setvarif																			returns zero if $?=0 returns 1 if $?!=9
	#1 setvarif [var_name]  															sets to 1 if $? is zero
	#2 setvarif [var_name] [file]													sets to file if exists
	#3 setvarif [var_name] [file] [fallback]									sets to file if exists, else sets to fallback [Fallback MUST exist, or the fourth incarnation will be used]
	#3 setvarif [var_name] [file] [if_found_value]							sets to if_found_value if exists
	#4 setvarif [var_name] [file] [if_found_value] [not_found_value]	sets to if_found_value if exists, not_found_value if it doesnt
	#2 setvarif [var_name] [+FLAG|-FLAG]                               if flag starts with + sets var_name to 1 if FLAG is found in .config/bashrc/flags dir, or flagsrc (on it's own single line)
   #                     				                                 sets var_name to 1 if flag starts with -, if it is NOT FOUND.																				
	 
	# determine [fallback] or [if_found_value] depends on
	# whether or not [fallback] is a file

	local _RV = $? # don't lose it
	case $# in
		0)				# zeroth incarnation
			[[ $_RV -eq 0 ]] && return 0 || return 1;;
		1)				# first incarnation
			[[ $_RV -eq 0 ]] && declare -g $1=1
		   return $_RV;;
		2)	
			if [[ ${2: 0:1} =~ [+-] ]]; then
				#final (fifth incarnation)
				local FLAGNAME=${2: 1}
				if [[ -r ~/.config/bashrc/flags/$FLAGNAME ]] || 
					grep ^$FLAGNAME\$ ~/.config/bashrc/flagsrc -qP &> /dev/null ; then
					[[ ${2: 0:1} == "+" ]] && local FLAGVAL=1 || local FLAGVAL=0
					declare -g $1=$FLAGVAL
				fi										
			else
				if [[ -r $2 ]]; then
					# second incarnation
					declare -g $1="$2"
					return 0
				else
					return 1
				fi
			fi
			;;
		3)	if [[ -r $3 ]]; then
				# third incarnation [file] [fallback] verbatim
				if [[ -r $2 ]]; then
					declare -g $1="$2"
					return 0;
				else
					declare -g $1="$3"
					return 1;
				fi
			else
				# fourth incarnation [file] [if_found_value] verbatim
				if [[ -r $2 ]]; then
					declare -g $1="$3"
					return 0;
				fi
			fi
			;;
		4)
			# fifth incarnation [file] [if_found] [not_found] verbatim
			if [[ -r $2 ]]; then
				declare -g $1="$3"
				return 0;
			else
				declare -g $1="$4"
				return 1;
			fi
			;;
		*)
			echo "Error: $FUNCNAME - bad call (see docs) args=$* rv=$? RV=$_RV"
			return 127
			;;			
	esac

}

function gui_avail()
{
	# this function's job is the end-all-be-all to determine beyond doubt that the
	# gui is running, available, and will be usable by the current user. There is
	# three factors that are used to figure this out:
	 local has_gterm=1;
	 local has_gui_access=0;
	 local has_pty=1;
	 # since the X executables and WM, DM, and UM can be various, they cannot be relied upon
	 # alone, nor can they fully be predicted or held responsible for giving accurate data.
	 # YOU MUST have a working terminal (of course you couldnt run bash without one in interactive
	 # mode), 2, you must have a DISPLAY that can be Opened/Closed by GUI programs from HERE, and
	 # 3, the terminal you are running must be issued via the ptmx interface. Since BSD/Unix/Linux
	 # does this differently on various systems, we dont check the ptmx, rather, we check for
	 # the TTY (/dev/tty) which is always the case except on over-the-line connections where it would
	 # be ptmx, which is the purpose for the 3-level check!
	 # MUST PASS ALL 3 CHECKS TO BE CONSIDERED "IN A GUI"
	# TODO: fixup for grep not working?
	# note: floating anchor regex
	[[ $TERM =~ (linux|fbterm|framebuffer|cons|ansi|tty|vt\d+) ]] &&	has_gterm=0
	[[ -v DISPLAY ]] && xprop -root &> /dev/null && has_gui_access=1
	[[ `realname -0 /proc/self/fd/0` =~ (\/dev\/tty) ]] && has_pty=0
	if [[ $has_gterm -eq 1 && $has_gui_access -eq 1 && $has_pty -eq 1 ]]; then
		return 1
	else
		return 0
	fi
}	

	function vim_settings()
{
		
		VIM_EXECUTABLE='/usr/bin/gvim'
		if [[ -x /usr/bin/kdesudo ]]; then
			SUDO_EXECUTABLE='/usr/bin/kdesudo'
		elif [[ -x /usr/bin/gksudo ]]; then
			SUDO_EXECUTABLE='/usr/bin/gksudo'
		fi


}
#{{{     vim [vim-compatible command line] (only expands search for files and induces sudo if needed): RV: vim's return code 
function vim()
{
	vim_settings
cat <<EOF
vim smartlauncher(tm) v0.0.2
(C)2013-14 Paradisim LLC, Gabriel T. Sharp <osirisgothra@hotmail.com>
homepage: http://paradisim.github.com/gxbase-extras-vimsl.git

processing "$*"...
EOF
	local -i USESUDO=0
	set -- $(str2which "$@")
	for i in "$@"; do
		if [[ -f "$i" || -d "$i" ]]; then
			if [[ ! -w "$i" ]]; then
				((USESUDO++))
				echo "$i -- file is write-protected, elevation level incremented" > $(tty)
			fi
		fi
	done
	echo "command translation: $*"
	sleep 0.5
	echo "executing vim..."
	if [[ $USESUDO -gt 0 ]]; then
		if [[ $(groups | grep -so sudo) == "sudo" ]]; then
			echo "authorized to level $USESUDO, must use sudo (and you are allowed)"
			command sudo /usr/bin/vim "$@"
		else
			echo "authorized to level $USESUDO: not in sudoers group, you must take some action to edit these files!"
			while [[ ! -x $CMD ]]; do
			[[ ! -z $CMD ]] && echo "command does not exist, try again!" ||	echo "Enter a command to edit these files (ie, sudo vim, kdesudo mousepad, altprog vim, etc):"			
				echo -ne "command-line? : "
				read CMD
			done
			echo "Attempting launch: $CMD $*"
			$CMD "$@"			
		fi
	else		
		command /usr/bin/vim "$@"
	fi
	# Important: error code preservation important here
	if [[ $? -eq 0 ]]; then
		for i in "$@"; do
			if file "$i" | grep "script" -q; then
				echo "Setting executable: $i"
				chmod a+x "$i"
			fi
		done
	fi
}
#}}}
# }}}

# {{{ load function editor functions
function _loadfunctioneditorfunctions()
{
	trap DEBUG
	test -x ~/.config/bashrc/shells/function-editor/function-editor-functions.iash && source $_ || {
	echo "Required script: $_ is missing!"
	echo "You do not have the function editor functions installed, you will need to install them"

	echo -ne "${SERVICE_WEBSITE+Find them at: }$SERVICE_WEBSITE${SERVICE_WEBSITE+\n}"
	}
	trap _startup_trap DEBUG
}
# }}}
# {{{    shufflehome() - randomized
function shufflehome()
{
	Kmul=${RANDOM: 0:3}
	Korf=${RANDOM: 0:3}
	Kofs=${RANDOM: 0:3}
	if [[ $PWD == ~ ]]; then		
		cd ~
	fi
} # }}}
# {{{    loadprs() [preset_name w/o path] OR [nothing to use ui]
function loadprs()
{
	if [[ -z $1 ]]; then
	
		declare -a ITEMS=( `for i in ~/.config/bashrc/ps1colors/*; do basename "$i"; done` )
		if [[ ${#ITEMS} -lt 2 ]]; then
			echo "ERROR: Preset directory needs at least 2 entries (the RESET entry and 1 preset)!"
			echo -ne "Reset? "
			if choice; then
				Korf=0
				Kmul=0
				Kofs=0
				cd .
				echo -e "\nReset Complete"
				return
			else
				echo -e "\nReset Cancelled"
			fi


		fi
		LOADPRS=`menu "${ITEMS[@]}"`	
		# clear (line) and move column to 0, and reset attributes...
		echo -ne "[2K[0G[0m"
	else
		LOADPRS="$1"
	fi

	if mapfile PRSLNS < ~/.config/bashrc/ps1colors/"$LOADPRS"; then
		if [[ ${PRSLNS[0]} != PRS100 ]] && [[ ${PRSLNS[4]} != END ]]; then
			echo "Failure: this is NOT a ps1 preset file! please delete invalid files from the presets!"
		else
 
			Kmul=${PRSLNS[1]}
			Korf=${PRSLNS[2]}
			Kofs=${PRSLNS[3]}
			cd .			
			printf "$LOADPRS" > ~/.config/bashrc/ps1colors.selection	
			echo "* Loaded $LOADPRS Home Colorscheme [configuration written to disk]"
		fi
	else
		echo "Error $?: Failed to load $LOADPRS"
	fi

}
# }}}
#   {{{  makeprs() -  UI to create a custom preset for loadprs
function makeprs()
{
	shopt -s extglob
	
	local UIMENU='/g/b/menu'
	local ADJ=Knone
	clear
	setterm -cursor off
	stty -echo 
	while (true); do
		# home-out do not clear (prevent flicker)
		echo -ne "[0;0H"
		cd .
		echo $PS1 | sed --regexp-extended 's/\\(\[|\])//g'
		echo ""

		printf "Multiplier Orfactor Offset\n"
		printf "%05d\t%05d\t%06d\n" $Kmul $Korf $Kofs
		printf "%05s\t%05s\t%06s\n" "UP/DN" "<-\->" "PUP/DN"
		printf "  KEY\t[END]\tQUITS"
		read -sn3
		case $REPLY in						
			$Left) ((Korf--)) ;;
		  $Right) ((Korf++)) ;;
	  		  $Up) ((Kmul++)) ;;
  			$Down) ((Kmul--)) ;;			
			$PgUp) ((Kofs++)) ; read -sn1 ;; # \ 
			$PgDn) ((Kofs--)) ; read -sn1 ;; # | pick up extra character generated (trailing ~)
			$Home) shufflehome  				;; # /
			$End) 				  setterm -cursor on
			  						  stty echo
		  							  echo -e "\nAborted\n"
									  REPLY=`menu SAVE NOSAVE`
									  case $REPLY in
										  SAVE)
											  printf "\nPreset Name: "
											  read PRSNAME
 											  [[ ! -d  ~/.config/bashrc/ps1colors ]] && mkdir --parents ~/.config/bashrc/ps1colors
											  printf "PRS\n$Kmul\n$Korf\n$Kofs\nEND" > ~/.config/bashrc/ps1colors/$PRSNAME
											  printf "\nSaved.\n"
											  ;;
											NOSAVE)
												printf "\nSkipped Save:\n"
												printf "\nYou can save it later manually by re-entering and not changing anything.\n"
												;;
										esac
					         		return	
									;;
		esac
	done



		
	
	



}
# }}}
#{{{     find_in_path [item] RV: err=1 ok=0
function find_in_path()
{
	# empty string
	if [[ -z $1 ]]; then
		return 1
	# string starting with a dash (switch) -
	elif [[ ${1: 0:1} == "-" ]]; then
		return 1
	fi
	# local keeps things from being permanantly changed
	local OLDIFS="$IFS"
	export IFS=":"	
	local OLDPATH="$PATH"
	export PATH="$PWD:$PATH${FIND_IN_EXTRAS+:$FIND_IN_EXTRAS}"
 
	local -i RETV=1
	for x in $PATH; do
		if [[ -f ${x}/$1 ]]; then
			echo ${x}/$1
			RETV=0
			break
		fi
	done
	export PATH="$OLDPATH"
	export IFS="$OLDIFS"
	return $RETV
}
#}}}
# {{{ shopt_toggle() 
function shopt_toggle()
{
	if shopt "$@"; then
		shopt -u "$@"
	else
		shopt -s "$@"
	fi
}
# }}}

# {{{    specialdiradded() [name/desc]
function specialdiradded()          
{
	local CRV=$? # retain $?
	 echo "Special directory [1m${1}[0m added."
	 return $CRV # retain $?
}
# }}}
# {{{    bindings() [no args] : list keyboard bindings w/o obvious stuff + commonly used keyboard mod decodings
function bindings()
{
	# ensure size checking on, this is just a failsafe and may not be needed
	# however, better to have it and not need it than to not have it and need it
	shopt -s checkwinsize
	# update $COLUMNS so pipe 'column' can use most recent setting (your terminal width)
:	eval `resize`
	bind -p 2>&1 |cat| grep -P '^[^#].+?(?<!self-insert|do-lowercase-version)$'  | tr -d ':"' | sed 's/\\C/ CTRL/g;s/\\e/ ESC,/g;s/\\M/ ALT/g' | column
}
# }}}
# {{{    select_prs() [prs-name] : select rainbow preset
function select_prs()
{
# TODO: remove function possibly, keeping for bw compatibility (?)
#       this function is now supersceeded by loadprs, and was never
#       fully done anyways, the gist started out like this code here:
#	OLDIFS=$IFS
#	IFS=":"
#	declare -a PRS=(${Kpresets[$1]})
#       - lines moved to loadprs and some deleted - cut here - -
# TODO: removed function, but delegate to loadprs for now (compatible)
	loadprs "$@"
	return $?
}
# }}}
# {{{    _selfreload() [no args] - resource calling function from .bashrc 
function _selfreload()
{
	# get caller
	set -- ${FUNCNAME[1]}

	if [[ "$*" == "$FUNCNAME" ]]; then
		echo "Warning: resourcing _selfreload, your results may not be as expected (old resourcing new)"
	else
		# TODO: planning implementation in process, soon to finish
		# source from .bashrc
		LINE_START=`cat ~/.bashrc | grep '^\s*function\s+'"$*"'\(\)\s*$' -Pl`

	fi

}
# }}}
# {{{    histcount() - returns last history entry number
function histcount()
{
	local r=`history | tail -n-1 | grep -P '^\s*\d+' -o | tr -d ' '`
	return $r
}
# }}}    
# {{{    alias_add()
function alias_add()
{
	if [[ $2 == last ]]; then
		# Note: history item printed, the number is by HISTCMD
		#       subtracting 2 because: -1 because HISTCMD refers to the next AVAILABLE history slot
		#                              -1 because this command (the eval) counts as a command but never get's added
		#                              w/o this compensation, the expansion and the entry would point two slots down the road!
		#  HISTCMD=last_hist_number+1->eval(increments HISTCMD, making it +2)->history -p called, HISTCMD decremented by 1
		#          and the next command is right back to what it was before
		eval alias $1=`eval "history -p !"$[ HISTCMD-2 ]`
	elif [[ $# -ge 2 ]] && [[ $2 -lt 1 || $2 -gt `histcount` ]]; then
		# if you want single quotes here, include them in your command
		eval alias $1=\'${@: 2}\'
	elif [[ $# -ne 2 ]]; then
		echo "usage: alias_add [name] [alias-definition]"
	   echo "	    alias_add [name] [valid history number]"
 	   echo "       alias_add [name] last"		
 	   echo "       alias_add [name] last -[number-of-commands-ago]"
	else		
		builtin alias $1=`history -p !$2`
		builtin alias $1 >> ~/.bash_aliases		
	fi	

}
# }}}
# {{{    add_find_dir() [directory] : adds a directory to FIND_IN_EXTRAS
function add_find_dir()
{
	#TODO: redirect this to ~/.config/bashrc/userconf/find_dirs
	if [[ -d $1 ]]; then
		echo "adding find directory $1.."
		echo "FIND_IN_EXTRAS+=\":$1\"" >> ~/.bashrc
		FIND_IN_EXTRAS+=":$1"
	fi
}
# }}}
# {{{    cat_minus_line() [line #-to-remove] [filename]
function cat_minus_line()
{
	local -i RLINE=${1-0}
	head  -n$(( RLINE -1 )) /home/gabriel/.bashrc
	tail -n+$(( RLINE +1 )) ~/.bashrc
}

# }}}
# {{{    rem_find_dir() [dirname] : removes a directory from FIND_IN_EXTRAS  
function rem_find_dir()
{
	if [[ -d $1 ]]; then
		echo "removing find directory $1.."
	  if ENTRYNO=$(grep -Poison "FIND_IN_EXTRAS\+=:$1" ~/.bashrc | grep -Poiso "^\d+"); then
			echo "found entry #$ENTRYNO, removing"
			cat_minus_line $ENTRYNO ~/.bashrc > .bashrc.tmp
			mv ~/.bashrc ~/.bashrc_previous
			mv ~/.bashrc.tmp ~/.bashrc
		fi
	fi			
}
# }}}
# {{{    undo_last_change() [nil] : restores last saved backup of .bashrc (stamps the current one)
function undo_last_change()
{
	cp ~/.bashrc ~/.bashrc_$(date +"%m%d%y_%H%M_%S")
	mv ~/.bashrc_previous ~/.bashrc -f
}
#}}}
# {{{     stow_bashrc()
function stow_bashrc()
{
	cp ~/.bashrc ~/.bashrc_$(date +"%m%d%y_%H%M_%S")
}
#}}}
# {{{    eb() : edit ~/.bashrc and ~/.bashrc-git 
function eb()
{
	rm -f /tmp/bashrc /tmp/bashrc-git
 	cp ~/.bashrc /tmp/bashrc
	cp ~/.bashrc-git /tmp/bashrc-git
	# -p = open each in a tab, show .bashrc first!
	touch ~/.bashrc ~/.bash_logout ~/.profile ~/.xinitrc ~/.inputrc ~/.netrc
	vim -p ~/.bashrc ~/.bash*       ~/.profile ~/.xinitrc ~/.inputrc ~/.netrc
	source ~/.bashrc
}
# }}}
# {{{    src() [dpkg,apt-get source package name, or git URL]
function src()
{
	if [[ $1 =~ ^http://.*$ ]] || [[ $1 =~ ^git://.*$ ]]; then
		echo "Yup, it's a git url...'"
		return 0;
	fi

	# dont want to iterate through non-existant globs (literally, *.zip, etc)
	shopt -s nullglob
	if apt-get source "$@"; then
		if [[ -x clean ]]; then
			echo -n "clean found, running it..."
			./clean
		else
			echo -n "removing archive files..."
			for i in *.gz *.dsc *.xz *.tar *.ark *.arj *.zip *.rar; do
				[[ -r "${i}" ]] && rm -f "${i}" &> /dev/null
			done
		fi
		echo "taking ownership..."
		eval chown $UID:$UID $*\* -R
		if [[ $? -eq 0 ]]; then
			echo "ownership acquired"
		else
			echo "warning: ownership take may have failed... please take your ownership manually!"
		fi
		echo "done"
	else
		echo "src failed ($?)"
	fi
  	shopt -u nullglob
}
#}}}
# {{{     parentshave [dir to find in PWD or PWD's parents] (note: it means Parents Have, not "Parent Shave" :) )
function parentshave()
{
	declare -ig PARENTSHAVE_DEPTH_TO_TARGET=-1
	declare -g PARENTSHAVE_TARGET=""

	builtin pushd . &> /dev/null
	while [[ $PWD != "/" ]]; do
		let PARENTSHAVE_DEPTH_TO_TARGET++
		if [[ -d "$1" ]]; then
			PARENTSHAVE_TARGET="$PWD"
			popd &> /dev/null
			return 0
		else
			# prevent special handling
			builtin cd ..
		fi
	done
	unset PARENTSHAVE_TARGET
	# never found one, restore previous dir 
	builtin popd &> /dev/null
	return 1
}
#}}}
#{{{ sessf
function sessf()
{
	[[ -z $1 ]] && { echo "Need a command!"; return 1; }
	case $1 in
		del)
			CMD=rm; ARG=$2;;
		add)
			CMD=touch; ARG=$2;;
		list)
			CMD="ls -C1"; ARG='*';;
		query)
			CMD="test -r"; ARG=$2;;
		*)
			echo "Invalid command: $1, ${2+Args=}$2]"
			return 124;;
	esac
	$CMD ~/.config/bashrc/flags/${ARG}_SESSION
	return $?		
}
#}}}
#{{{     switch_which [item] = returns item in PATH that would be executed FIRST, or if not executable, first found in config, lib, or binaries directory, if that fails, whereis takes over
function switch_which()
{
	# -- is important: since switches also get passed here 
	# we dont need them to be misinterpreted as basename switches!
	# IMPORTANT: THIS COMMAND'S RESULT MUST BE REDIRECTED TO STDOUT
	# IF YOU NEED TO ECHO TO SCREEN YOU MUST USE $(tty) TO DO IT!
	# (or $TTY, if validly updated)
	BASENAME=$(basename -- "$*") 
	local sel=""
	if [[ -f "$*" ]]; then
		# always give the local names first
		echo "$*"
	elif [[ "$BASENAME" =~ ^".".* ]]; then
		# do not modify path of names that are 'hidden' files!
		# NOTE: this must be done because 'whereis' cannot handle filenames that start with dots
		#       and hidden files will most likely not be found by 'which' or 'find_in_path'.
		echo "$*"
	elif WHICH=$(which -- "$*" 2> /dev/null); then
		echo -ne "$WHICH"
	else
		if WHICH=$(find_in_path "$*" 2> /dev/null); then
			echo -ne "$WHICH"
		else
			WHERE=($(whereis "$*"  2> /dev/null | tr ' ' '\n' | tail -n+2))
			local -i count=${#WHERE[@]}
			if (( count == 1 )); then
  				echo "$WHERE"
			elif (( count > 1 )); then
				echo -e '\nItem [1m"'$*'"[0m is a near-match for the following files (under the guise of whereis):\n' > $(tty)
				PS3=$'\nPlease Enter the NUMBER of the file you wish to use, or\nspecify the full path and filename: '
	 			select sel in "${WHERE[@]}"; do
					if [[ -z $sel ]]; then
						# user entered something else
						if [[ -r $REPLY ]]; then
							echo -ne "$REPLY"
							break
						else
							echo "Warning... file inaccessable it will be created or restricted." > $(tty)
							LASTREPLY=$REPLY
							unset LASTREPLYSELECTED 
							select sel in yes no; do
								if [[ $REPLY == "yes" ]]; then
									echo -ne "$LASTREPLY"
									LASTREPLYSELECTED=Y
									break
								fi
							done
							unset LASTREPLYSELECTED, LASTREPLY 
							if [[ $LASTREPLYSELECTED == "Y" ]]; then break; fi
						fi
					else
						# user selected a valid one
						echo "$REPLY"
					fi

			  	done	 				
			else				
				echo "$*"
			fi
		fi
	fi	
}
#}}}
#{{{     str2which [string] <stdout>=nearest-match RV: ignore
function str2which()
{
	local FIRST=""
	for i in "$@"; do
		if [[ -z $FIRST ]]; then
			FIRST=1
		else
			echo -ne " "
		fi
		nexti="$(switch_which "$i")"
		if [[ $nexti =~ " " ]]; then
			echo -ne "\"$nexti\""
		else
			echo -ne $nexti
		fi
	done
}
#}}}
# }}}
#{{{ COMPLETION
#{{{ complete commands
	# on-the-fly completion additions complements the super-builtin complete
	source ~/.bash_completion
	complete -F _debconf_show src 	# for the src() function
#}}}
# }}}
#{{{ POSTINIT 

# {{{ Shell Integration

#{{{ SPECIAL DIRECTORIES (used by 'cd' function)

#{{{ GITSH integration

#{{{ Save Aliases To This Point (dont define normal aliases after this) into ORIGINAL_ALIASES array
eval `declare -p BASH_ALIASES | sed 's/BASH_ALIASES/ORIGINAL_ALIASES/'`

#}}}
#{{{ Set Normal Prompts (needs 2 passes!) and keep original PWD in ZOLDWD for the post multi-pass
# my interactive stuff KEEP LAST
PS1_NORMAL=$PS1
PS2_NORMAL=$PS2
source ~/.bashrc-git
PS1_GIT=$PS1
PS2_GIT=$PS2
#}}}
#{{{ Create Dummy Repository To Cache GitSh's Aliases for Swapping
if [[ ! -d "$GITDSITE" ]]; then
	# use -p that way you can specify something like /var/tmp/these/dirs/dont/exist/dummy
	declare -i SUCCESS=0
	if mkdir -p "$GITDSITE"; then
		if cd "$GITDSITE"; then
			if git init .; then
				if git add --all .; then
					if git commit -m 'dummy commit'; then						
						SUCCESS=1
					fi
				fi
			fi
		fi
	fi
else
	if cd "$GITDSITE"; then
		SUCCESS=1
	fi		
fi
if [[ $SUCCESS -ne 1 ]]; then
	echo "Fatal: creation/use of the repository failed, please check global variables in $BASH_SOURCE as soon as possible. The GIT repository sensing features will NOT work until you do this."
else
	specialdiradded "[dirs with .git=gitsh]"
fi
#}}}
# {{{ Test-Cycle gitsh
cd "${GIT_DUMMY_SITE}"
cd "$ZOLDWD"
# }}}
# }}}
# {{{ APTSH integration
# remember, dont warn if feature is unavailable (the user wont care)
if [[ -x $(find_in_path aptsh) ]]; then
	# is_patched_version: does not yield output
	# regular version: yeilds: 'command not found: is_patched_version 
	aptsh is_patched_version &> /dev/null
	# our 'special' patched aptsh will give us the magic number 14 as a response (and no output)	
	if [[ $? -eq 14 ]]; then
		specialdiradded "/apt"
		export APTSH_USESPECIALDIR=1
	fi
fi
# }}}
# {{{ PERLCONSOLE integration
# the integration version of perlconsole features the use of the 'hostname' command
# from within the 'Console.pm' (the high level interface opposite of lexical)
if grep -Pq 'hostname' /usr/share/perl5/PerlConsole/Console.pm &>/dev/null; then
	export PERLCONSOLE_USESPECIALDIR=1
	specialdiradded "/perl-console"
fi
# }}}
# {{{ @FILE integration
export ATFILE_INTEGRATION=1
specialdiradded "@file"
# }}}

# }}}

# }}}
# {{{ TERM detection

# {{{ Attempt Autodetect TERM type

# Currently supports autodetect for:
#     xterm         rxvt           fbterm
#     

if [[ -z $DISPLAY ]]; then
	if ps $PPID | grep -q fbterm; then
		if [[ -f /usr/share/terminfo/f/fbterm ]]; then
			echo "Terminal \"fbterm\" (termcap found OK) being used (frame-buffer terminal)"
			echo "Notice: xterm color emulation will be attempted internally only."
			export TERM=fbterm
		else
			echo "Fatal: \"fbterm\" terminal (termcap) cannot be used, the fbterm terminfo file"
			echo "       is not installed. Try `which sudo` `which dpkg-reconfigure` 'fbterm'."
		fi		
	else
		if ps $PPID | grep -q screen; then
			echo "Terminal \"screen\" being used (byobu-screen, screen, etc)"
			export TERM=screen
		elif ps $PPID | grep -q tmux; then
			echo "Terminal \"tmux\" being used (byobu-tmux, tmux, etc)"
			export TERM=tmux		
		else		
			export TERM=linux
			echo "Terminal \"linux\" being used (on hard console)"
		fi
	fi
elif command ps $PPID | grep xterm -qos; then
	# really is xterm, so make the thing compatible (expected by some)
	export TERM=xterm
	echo "Terminal xterm (not an xterm-clone)"
elif command ps $PPID | grep rxvt -qos; then
	# really is rxvt, force this for 256-color
	export TERM=rxvt-unicode-256color
	echo "Terminal rxvt forcing 256-color"
else
	# we do not want to specify a default, let the terminal program's TERM variable shine through!
	# since it's termcap is probably 'special' 
	# TODO: put a verification of some type here
	echo "Terminal $TERM	being used (no modifications)"
fi

# make terminal happy
setterm -i
stty sane

#}}}

# }}}
# {{{ Experimental (and potentially nonstandard) Last-Init Setup

#whenever reliance on $_ is used, you MUST disable the startup trap, or else
# you will get $_=_startup_trap instead of what is expected. This is the same
# for other traps as well. Backup is important enough to not allow insertion
# into emergency mode until after it is done, however, the user presses 'E'
# during the backup, they will still be put into "emergency mode" once it is
# safe to do so, thanks to readline buffering.

trap DEBUG
if [[ $BASHRC_BACKUPS != OFF ]]; then
	export PATH=$PATH:/home/gabriel/.vim/bin
	# make a dated backup of this file in /var/archive/bashrc if possible (zipped)
	if [[ -w /var/archive/bashrc ]]; then
	RECENT_BASH_BACKUP_TARGET="/var/archive/bashrc/$(date +'%m%d%y_%H%M%S')_$USER"
	if cp $BASH_SOURCE $RECENT_BASH_BACKUP_TARGET; then
		if ! gzip -9 $_; then
				echo "Warning: failed to compress(gzip) backup - $_ ($?)"
			fi
		else
			echo "Warning: failed to copy(cp) backup - $_ ($?)"		
		fi
	else
		echo "Note: You are not keeping backups, please create a writable path in /var/archive/bashrc!"
		echo "      or turn off backups by setting BASHRC_BACKUPS to OFF."
	fi 
else
	if ! test -r ~/.config/bashrc/flag_backupwarning; then
		touch $_
		echo "One-Time Warning: BASHRC_BACKUPS is now OFF, backups will not be made"
		echo "                  you must set it to ON or undefine it to allow backups,"
		echo "                  and create the archive in /var/archive/bashrc!"
		echo "(this message will NOT show again for this user unless the settings are wiped)"
	fi
fi

trap _startup_trap DEBUG

# }}}
# {{{ Make Function Calls

## {{{ loadprs
if [[ -r ~/.config/bashrc/ps1colors.selection ]]; then
	loadprs `cat ~/.config/bashrc/ps1colors.selection` # you might want something different
else
	loadprs RESET > /dev/null
	echo "No preset shell style selected"
	echo "You need to select one (or dont to use default)"
	loadprs
fi
## }}}
# {{{ _loadfunctioneditorfunctions
if [[ -d ~/.config/bashrc/functions ]]; then
	_loadfunctioneditorfunctions "$HOME/.config/bashrc/functions"
fi
# }}}

# }}}

# }}}
# {{{ KEYBOARD BINDINGS

bind  -x '"[21~":mc;echo "[A[A"'
bind  -x '"[20~":mocp;echo "[A[A"'
bind '"\C-i":apt-get install $1'
bind '"\C-f":apt-cache search $1'
bind -x '"\C-w":apt-cache show $_'
bind -x '"\C-u":apt-get update;apt-get upgrade --yes'
bind '"	":complete'		# ensures tab completes, always

# }}}
# {{{ CLEANUP
	
	# remove traps used during startup	
	# DEBUG,RETURN: used by EMS (emergency startup system)
	trap DEBUG
	trap RETURN
	# give back INT, allows user to press CTRL-C again
	trap INT
	
	# remove functions useless outside the .bashrc
	unset -f mkdirif 
	unset -f _startup_trap

	# reinstate command not found handler
	function command_not_found_handle() 
	{
		# prevent non-ineractive commands from doing this (or null ttys)
		# uncomment these lines if you really need this kind of support
		# (this WILL slow it down a bit especialy when debugging scripts!)
#		case $- in	
#			*i*)					
#				case `tty` in 
#					*tty*|*pts*) 
#						echo ""
#					  	;; 
#					*) 
#						return 
#						;; 
#				esac 
#				 
#				;; 
#			*) 
#				return $?
#				;; 
#		esac
		# TODO: make a session-specific flags dir, and put these here
		#       to do that, we'll need session-storage/session-load/save routines in place first.
		[[ -r ~/.config/bashrc/flags/ALWAYS_CHECK_SESSION ]] && local ALWAYS_CHECK_SESSION=y
		[[ -r ~/.config/bashrc/flags/ALWAYS_INSTALL_SESSION ]] && local ALWAYS_INSTALL_SESSION=y

		# prevent overwriting of the global or other local $REPLY that might be out there
		local REPLY=""	
		# you could set these permanantly to y, if you want it to persist (not recommened!)	
		if [[ $ALWAYS_CHECK_SESSION == y ]]; then
			REPLY=y
		else 	
			echo -ne "$*: Not Found, Want to check [enter or N=skip, Y=check, A=always/session] ? "
			read -sn1 
			if [[ $REPLY =~ [Aa] ]]; then
				REPLY=y
				touch ~/.config/bashrc/flags/ALWAYS_CHECK_SESSION 
			fi
		fi 

		if [[ $REPLY =~ [Yy] ]]; then
			if [[ -x "/usr/lib/command-not-found" ]]; then
				echo "Checking..."
				RESULT=`/usr/lib/command-not-found "$@" 2>&1`
				echo "$RESULT"
				if INSTALL_RESULT=`echo "$RESULT" | grep "(apt-get|sudo apt-get).*"`; then
					if [[ $ALWAYS_INSTALL_SESSION == y ]]; then
						REPLY=y
					else 	
						echo -ne "Want to Install? [enter or N=no, Y=install, A=always/session] "
						read -sn1 
						if [[ $REPLY =~ [aA] ]]; then
							REPLY=y
							touch ~/.config/bashrc/flags/ALWAYS_INSTALL_SESSION
						fi
					fi 
					if [[ $REPLY =~ [yY] ]]; then
						echo "Attempting install..."
						$INSTALL_RESULT
						echo "install completed with code $?"
					fi
				else
					echo "No install suggested, no further checks made."
				fi	
			else
				echo "Can't check, command-not-found is not installed in usr/lib!"
			fi							
		else
			echo "Skipped"
		fi
	}
	


# }}}
#{{{ Revision Information
#			Revision Sep 16 2014 11:48pm
#        Revision Aug 11 2014 11:59pm 
#}}}
