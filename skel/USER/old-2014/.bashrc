#!/bin/bash --norc -rc 'echo "This script must be loaded by bashrc, not explicitly ran."' 
# {{{ VIM Users Warning: if this file is not organized into folds (vim users) then check your 'modeline' setting (:set modeline, not :set nomodeline) in your .vimrc file!
#          this file will be hard to edit in any other text editor, or, without folds. }}}
# {{{ README for (/gxbase/skel/USER/current/.bashrc (original) -> ~/.bashrc (install/link location))
# {{{ REVISION HISTORY (READ THIS FIRST!)
# 2012-28-Dec to 2013-9-Oct: gxbase (known previously as my .bashrc 'extras' nicknamed 'extbash' and later 'extbase'
# ------------------------------------------------------------------------------------------------------------------
# It started as a collection of files I wanted to keep under version control so I could make changes and keep live
# backups to my hearts content. I named it because of this, since everything on git has to have a name, this was before
# I knew about branches and stuff, and was my first year 'back' in linux since the old pre-fedora redhat days (and before that, freebsd, etc)
# As things got closer to 10/2013, I decided to rename it to gx bash/e or 'general extension of bash configuration files' which
# later became 'gxbase' which is 'general extension of bash entities' (entities meaning configuration, functions, aliases, builtins, etc)
# the first years worth of updates were lost due to my inferior knowledge of git and gitorious, but a solid branch finally emerged (re-committed
# from local backups here and there) into the 0-1-0 branch, which then finally became 0.1.0 and the date-based branch it is today (2015 January)
# from g-sharp/osirisgothra@hotmail.com -end entry-
# -
# 2013-10-Oct to 2014-10-Aug: gxbase 'floating' bash configuration
#-----------------------------------------------------------------
# I originally though of gxbase as a 'separate' entity from my .bashrc (or the user's bashrc) and wanted to develop a system tree
# of it's own, which has now failed not once, not twice, but 3 times. There are so many sparatic bash scripts, linked to each other
# into .config, ~/.* files, and the occasional doc, vim, and xml extra or config, my brain can't even contain it, and it's all
# a big mess. It was my fault for not planning it in the first place properly. (half planning is more like it). The
# gxbase 2-x-x repositories, etc etc [read on in osirisgothra.gitorious.org or github.com gxbase via google]
#
# this sad overbloat of textual nightmares leads me now in a text editor that is 95% overworked and
# a gui that 99% on the brink of being out of memory (using 1% for swapping in/out forever)
# -end of entry -
#
# 2014-11-Aug to 2015-15-Jan: major reform of gxbase code, revisions noted on exact dates below for signifigant changes
#------------------------------------------------- --------------------------------------------------------------------
# Revision Aug 11 2014 11:59pm
# - First addition of migration from gxbase/core|bin into /gxbase/skel/USER/current/.bashrc
# Revision Sep 16 2014 11:48pm
# - Fold Insertion for sorting under vim/gvim/qvim (see notes!)
# Revision Dec 12 2014 11:33am
# - Major insertions of /gxbase/bin and /gxbase/core, complete rewrite of vimXXX loader
# - No more info on this until after the revision is done, projected at the 12th of Jan, 2015!
#


# }}}
#{{{ SPECIAL NOTES
# 1a. Keep the gxbase file ownership as a group/user combination you can read/write/execute
#     refrain from giving any gxbase related files root permissions, especially not SetUID/SetGID.
# 1b. To use tags, make sure you compile the tags file with the makebashtags command from this script
# 1c. YOU WILL NEED ctags-exhuberant to compile the tags when things change, especially functions.
# 2. If you change your tags location, make sure you update the modeline (line 8) with the location
#    which is by default, ~/tags, this is the default for most versions of vim and is always accesibl.
# 	  if you aren't a admin.
# 3. This document is best viewed with the following editors:
#      0: (new) gvim (actually, i am using qvim in disguise since it's style can be edited to match the colorscheme!)
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
 #{{{ EXPERIMENTAL!!! <- NOTES ABOUT AREAS WHEN YOU SEE THIS
 # This entire script is pretty much expermental as far as release-ability is concearned. However, there are
 # places that are even more so. Three of those areas need to be noted here. The others are just small fry and
 # can be ignored without too much guilt:
 # 1) PREINIT - since shells are starting up, shutting down, crashing, breaking, debugging, halting, continuing, and all of this
 #              happens in interactive, non-interactive, tty-less, and X-available, multi-terminal modes. This is very complex when
 #              you also decide to add in different users, their preferences, shell configurations, security permissions, and network
 #              locations. Not to mention, good old hardware capability. The PREINIT robustness is in it's process, trying to recognize
 #              a good bit of this to perform a bit better, give extra features to those who need it (and trim out features for those who
 #					 dont/cant have or want it). This will never be done completely, which is why it is disabled by default. If you are curious
 #              take a look but it is a mess. IT WILL BE REWRITTEN SEVERAL THOUSAND TIMES before I start enabling it by default, so dont cry!
 # 2) HOOKS  -  Shell hooks are not essential for most. But if the feature were sound, it could make some great new features of mulittasking
 #		          become available to the shell user. Most of this is in the pursuit of my own terminal emulator, which is not even ready for
 #              testing because it hardly exists. It is for this that I have started this for. Turn it on, and it may cause more harm than
 #              good as it is incomplete.
 # 3) POSTINIT- Cleanup code, mostly, and most of the experimental postinit has to do with reloading the bash config on-demand. That said
 #              MOST of it works with the HOOKS, since they aren't ready yet, neither is this. You CAN use the reload hooks manually, however!
 #
 #}}}
# }}}

# {{{ INTERACTIVE CHECK

[[ $- =~ i ]] || { return; exit; }

# }}}
# {{{ PSEUDO SYNTAX: built-ins, functions, etc used throughout the land

# {{{ set/shopt constraint checking
# {{{ explanation - read first!
# Set and shopt severely alter how the shell works. When dealing with an elaborate script environment such as gxbase, control must be
# maintained over set/shopt to ensure no bugs sneak in. The way it is supposed to work, is when any interactive script or function causes
# a shell option to change beyond this point, it needs to get re-set back when it is done. However, this is not always the case. For this
# reason, shopt and set are overridden to provide a stack. Of course I have not quite decided how to implement this as a whole yet but it
# has one good feature: making a big fuss by telling on functions that change shell options aloud, this makes the user aware of what is
# being changed, so they don't wonder why completion stops working or why suddenly other features seem unresponsive for apparently no
# reason. 
# Sections:
#   - SHOPT - shell options imperative to the operation of gxbase-d shell environment
#   -   SET - shell options (shopt -o's) with the same mission
#   - shopt - override to manage a stack in the BASH_SHOPT_STACK
#   -   set - wrapper to convert set -flags to shopt -o's and thus add to the stack (other uses are treated normally)
#   - shpop - returns the shell's settings to their previous state (step by step)
#   -shpopa - returns all shell settings to normal
# }}}

# {{{ SHOPT (shell options)

shopt -s checkwinsize
shopt -s histappend
shopt -s extglob
shopt -u nullglob
shopt -s globstar

# }}}
# {{{ SET (required environment settings)

set +x && [[ -r ~/.debug-bashrc ]] && set -x
set +H

# }}}
# {{{ shopt override
	function shopt()
	{		
		
		echo "`caller` has called shopt with: $@"
		if [[ ! -v BASH_SHOPT_STACK ]]; then
			declare -agx BASH_SHOPT_STACK
		fi
		BASH_SHOPT_STACK+=( "$*" )
		builtin shopt "$@"
		return $?
	}
# }}}
# {{{ set override
	function set()
	{
		if [[ "$*" == "--help" ]]; then
			help $FUNCNAME
			return 1
		fi
		echo "`caller` has called set with: $@"
		if [[ ! -v BASH_SHOPT_MAP ]] || [[ $(declare -p BASH_SHOPT_MAP) =~ ^declare\ -A ]]; then
			unset BASH_SHOPT_MAP &> /dev/null
			declare -A SHOPTMAP='([nounset]="-u" [verbose]="-v" [histexpand]="-H" [errexit]="-e" [noexec]="-n" [hashall]="-h" [notify]="-b" [errtrace]="-E" [privileged]="-p" [onecmd]="-t" [keyword]="-k" [braceexpand]="-B" [physical]="-P" [functrace]="-T" [noclobber]="-C" [monitor]="-m" [allexport]="-a" [xtrace]="-x" [noglob]="-f" )' 	
		fi
		

	}
# }}}
# {{{ shpop, shpopa - return shopt/set changes to normal stepped,at once (respectively)


# }}}

# }}}
# {{{ aliafun, unaliafun - an 'alias builtin with parameter support' emulation
# {{{ "aliafun" documentation and notes
# NOTES: - aliafuns are just functions that declare like aliases, they ARE functions in the end
#        - unaliafun deletes the function made by aliafun
#        - does unaliafun delete any function? NO.. it must have a special tag created at the time of declaration
#          which prevents legitamate functions that are NOT aliafuns from being deleted with the added advantage
#          of not needing an additional array to hold the aliafun list (there is no BASH_ALIAFUNS) though you
#          can get one by using BASH_ALIAFUNS=( `aliafun` ).
#
# }}}
# {{{ aliafun alias_name='legal bash expression or expression group'
function aliafun ()
{
	uses WARN;
	uses __isflag;

	case $# in
		0)
			# temporary, eventually it should mimic typing 'show BASH_ALIASES' or typing 'alias' alone,
			# depending on the value of ALIAFUN_USE_ALIAS_COMPATIBLE_LISTING flag or variable
			if __isflag ALIAFUN_USE_ALIAS_COMPATIBLE_LISTING; then
				WARN "Not yet available: ALIAFUN_USE_ALIAS_COMPATIBLE_LISTING"
			fi
			declare -pf | perl -wen 'print if s/^\s+local\sALIAFUN_TAG=([^;]+)(;)/$1/'
			;;
		1)
			set "${1%%=*}" "${1##*=}";
			eval "function $1() { local ALIAFUN_TAG=$1; $2; }"
			;;
		*) for p in "$@"; do
				aliafun "$p"
			done
			;;
	esac
}
# }}}
#{{{ unaliafun alias_name -- remove an aliafun (must exist or you get the usual 'not found' error message)
function unaliafun ()
{
	if [[ `declare -pf $1 2>/dev/null` =~ ALIAFUN_TAG ]]; then
		unset -f $1;
	else
		echo "Unknown aliafun: $1";
	fi
}

#}}}
#}}}
# {{{     slice_func() - slice a 'function()' out of .bashrc (or $1) and declare it right away
function slice_func()
{
	[[ -r $HOME/.bashrc ]] && local default_slice="$HOME/.bashrc" || local default_slice="$BASH_SOURCE"
	
	# pre-filter
	case $# in
		0)
			echo "usage: $FUNCNAME [file] target [ [file2] target2 ... ]"
			return 1;;
		1)
			if [[ -r $default_slice ]]; then
				slice_func $default_slice "$1"
			else
				echo "critical error in $FUNCNAME: $default_slice not readable (anymore?) cannot default slice function!!!"
				return 254
			fi
			return $?;;
		2) if [[ ! -r $1 ]]; then
				slice_func $1
				RET1=$?
				slice_func $2
				[[ $RET1 == 0 ]] && return $? || return $RET1
			else
				# fall through, and execute
				:
			fi;;
		*) # multiple arguments
			for ((i=0;i<$#;i+=2)); do
				if [[ $(( $i + 1 )) -le $# ]]; then
					slice_func "${@: i:2}"
				else
					slice_func "${@: i:1}"
				fi
			done;;
	esac

	# at this point, $1 is always the source filename, and $2 is always the target function to be loaded

	TMPFILE=$(mktemp)
	TMPLOG=$(mktemp)
	SOURCE="$1"
	TARGET="$2"
	cat "$1" | perl -ne "print if /^function $2/ .. /^}/;" > $TMPFILE
	if [[ ! -s $TMPFILE ]]; then
		echo "$FUNCNAME fatal: sourcing $TMPFILE ($TARGET) yielded no code, so not loaded!"
	else
		source "$TMPFILE"
	fi
	rm -f "$TMPFILE"
}
# }}}
# {{{    uses() - slice function if not yet loaded (forward compilation) NOTE: use slice_func to RELOAD functions
function uses()
{
	# notice: for obvious reasons, we should not 'use' other forward functions from here!! (like WARN or DEBM)
	#         such mechanisms will be counter-productive.
	if declare -pf "$1" &> /dev/null; then
		return 0;
	else
		slice_func "$@"
	fi

}
function needs()
{
	until false; do
		if declare -pf "$1" &> /dev/null; then
			return 0;
		else

			case $2 in
				outright)
					slice_func "$1"
					return 0
					;;
				passive)
					return 1
					;;
				repugnant)
					echo "Not Found: $1 ($2 failure, check your source(s)"
					read -p "[A] $ABORT_STR [R] $RETRY_STR ${RESTART_LOOP+[ # $RESTART_LOOP ]} [I] $IGNORE_STR" -sn1 ARI
					case $ARI in
						A) exit 251; return 251;;
						I) echo "WARNING: instruction need($*) continuing ignored, program WILL have errors! [press a key]"
							read -sn1 DISCARD
						  	return 0;;
					esac
					;;
			esac

		fi
	done
}
# }}}
# {{{ var name[subscript] (1) | var name subscript (2) | var name subscript = [shorthand] (4) |
#     var name[subscript]=[shorthand] | var name[subscript]=value
#     retrieve or assign values to subscripted variables
function var()
{
	case $# in
		0) { declare -pa; declare -pA; } | grep -oPs '^declare[^=]+';;
		1) # name[subscript] (show)
			NAME=`echo $1  | grep '^[^\[]+'`
			SUBSCRIPT=`echo $1 | grep '(?<=\[)[^\]]+'`
			declare -pa $NAME | grep '\['$SUBSCRIPT'\][^\[]+';;
		*)
			echo "NYI: Not Yet Implemented";;
	esac

}
# }}}
#{{{ defined [kind*] [name]   -- [*kind is required, must be a kind described below]
# [name] name to be searched for in the constraint (unless any is used)
# [kind] must be one of:
#
function defined()
{
	local searchkinds=( alias binding command disabled export function helptopic job running setopt signal user arrayvar builtin directory enabled file group hostname keyword service shopt stopped variable )
	if [[ $# -eq 1 ]] && [[ $1 == "list-kinds" ]]; then
		echo "The following values are acceptable for the KIND parameter:"
		echo
		eval `resize`
		echo "${searchkinds[@]}" | tr ' ' '\n' | column -c $COLUMNS
		echo ""
		echo "${#searchkinds[@]} kind(s)"
		echo ""
		return 1
	elif [[ $# -eq 1 ]]; then
		# guess the symbol's type *same as "any"
		# not recommended for checking variables and functions with common names!
		defined any "$@"
		return $?
	elif [[ $# -ne 2 ]] || [[ $# -eq 1 && $1 == "--help" ]]; then
		echo "usage: $FUNCNAME [kind] [name]"
		echo "       $FUNCNAME [list-kinds]"
		echo "       $FUNCNAME [symbol]"
		echo ""
		echo "OPTIONS"
		echo "The second form will give you a list of items that are acceptable for the 'kind' parameter in the first."
		echo "The third form will cause the symbol name to be guessed in the order of list-kinds"
		return 1
	fi

	local kind="$1"
	local name="$2"

	local FOUNDKIND=0
	for item in "${searchkinds[@]}" any; do
		if [[ $item == $kind ]]; then
			FOUNDKIND=1
		fi
	done
	if [[ $FOUNDKIND -ne 1 ]]; then
		echo "[1mError: kind \"$kind\" is not allowed![0m"
		defined list-kinds
		return 1
	fi
	if [[ $kind == "any" ]]; then
		local searchitems=( `compgen -A ${searchkinds[@]}` )
	else
		local searchitems=( `compgen -A $kind` )
	fi
	for item in "${searchitems[@]}"; do
		if [[ "$item" == "$name" ]]; then
			return 0;
		fi
	done
	# nothing found if here - so error!
	return 1

}
function typeof()
{
	local -i fcount=0
	local searchkinds=( alias binding command disabled export function helptopic job running setopt signal user arrayvar builtin directory enabled file group hostname keyword service shopt stopped variable )
	for i in `${searchkinds[@]}`; do
		for k in `compgen -A $i`; do
			if [[ $k == $1 ]]; then
				if [[ $2 == long ]]; then
					echo "$k($i)"
				else
					echo $i
					fcount+=1
				fi
			fi
		done
	done
	if ((!fcount)); then
		if [[ $2 == long ]]; then
			echo "$1(undefined)"
		else
			echo "<undefined>"
		fi
		if [[ $2 == times ]]; then
			return 0
		else
			return 1
		fi
	fi
	if [[ $2 == times ]]; then
		return $fcount
	else
		return 0
	fi
}

#}}}
# {{{    declare_prevalent [function_name] - creates the header that calls and reloads the stub
function declare_prevalent() # t(fname,fbody)
{
	PREVALENT_NAME="$1"
	shift
	eval "
	function ${PREVALENT_NAME}()
	{
		implement_prevalent ${PREVALENT_NAME}_stub \"\$@\"
	}"
}
# }}}
# {{{    prevalent_function [name] - still experimental
function prevlalent_function()
{
	eval "function ${1}_stub()"
}
# }}}
# {{{    implement_prevalent [func_name] [func_args] - reloads a stub and calls it with the arguments provided
function implement_prevalent()
{
	PREVALENTFUNC="$1"
   shift 
	if slice_func "$PREVALENTFUNC"; then
		"$PREVALENTFUNC" "$@"
		return $?
	else
		echo "$(date +"%H:%M:%S") error [$BASH_SOURCE:$FUNCNAME:$(caller)]: could not execute prevalant function \"$1\" on line $LINENO"
		return 253
	fi
}
# }}}

# {{{    TIMESECTION [header args] - set section's time format for the time builtin benchmarker
function TIMESECTION()
{
 TIMEFORMAT="* $* (%0R, %0U, %0S [%P%% CPU] @ $(date +"%H:%M:%S"))"
}
# }}}
# {{{ ALIASES - used in the language (some are experimental)

# so far, these cannot be used because of syntax checking in bash but work only on the command line
# they also break syntax checkers in IDEs such as komodo and vim
alias unless='if !'
alias until='while !'
# decoration only for helping ambiguity
alias untrap=trap

# }}}

# }}}
#{{{ PREINIT

# {{{ TIMED SECTION "PREINIT" SETUP / INIT FLAG[s]
TIMESECTION PREINIT; time {
export BASH_IS_INITIALIZING=1
# }}}
# {{{ SELECT EXPERIMENTATION MODE
#declare -g BASH_SESSION_EXPERIMENTATION_MODES # also, HOOKPROC, ROBUST_INIT, PERSISTENT
#for _em in "${BASH_SESSION_EXPERIMENTATION_MODES[@]}"; do
#	echo "[33;1m* $_em Expermentation Mode Is Activated[0m"
#done
# }}}
# {{{ EXPERIMENTAL FEATURES (Activate via SELECT EM above!)
case "${BASH_SESSION_EXPERIMENTATION_MODES[*]}" in
	*PERSISTENT*)
		trap : SIGSTOP
		trap : SIGINT
		;;&
	*HOOKPROC*)
		set -ET
		source ~/.config/bashrc/hookproc.sh
		;;&
	*ROBUST_INIT*)
		# {{{ !!! EXPERIMENTAL !!! -- MORE ROBUST PREINIT STUFF !!! EXPERIMENTAL !!!
		# disable preinit, experimental (for mig to 3.0)
		function _startup_trap() { return $?; } # dummy startup trap to avoid errors where small bits of it are used (and not disabled)
		if [[ -v DONT_DISABLE_PREINIT ]]; then
		# {{{ INITIALIZE SESSION


		if [[ -v BASH_SESSION_ID ]]; then
			echo "";
		else


			# {{{ REGULAR STARTUP (FIRST-TIME STARTUP)

			function __compactmode()
			{
							echo "Detected compact environment (console, non-terminal, etc)."
							echo "Starting in console mode with extensions disabled."
							echo "Reading skeleton bashrc, if it exists..."
							if test -r /etc/skel/.bashrc; then source /etc/skel/.bashrc; fi
							if test -r ~/.bashrc_console; then source /etc/skel/.bashrc; fi
			}
			case $- in
			 *i*)

					[[ ! -v TTY ]] && TTY=$(tty)
					# we ARE in interactive mode
					case $TTY in
						/dev/tty*)
							__compactmode
							return;;
						*)
							PARENT_PROCESS=$(ps --format='%c' --no-header $PPID)
							# detected a process parent other than a terminal we normally would use
							# used $TERM too, many other terminals process names are the same as their TERM type
							if [[ ! $PARENT_PROCESS =~ (konsole|getty|login|xgetty|gnome-terminal|xterm.*|rxvt.*|fbterm|.*screen|.*tmux|xfce4-terminal|Eterm|$TERM) ]] &&
								[[ $PARENT_PROCESS != bash || $BASH_COMPACT_MODE == 1 ]]; then
								export BASH_COMPACT_MODE=1
								__compactmode
								return;
							fi

							# don't install it if we don't have the kbhit program!
							if which kbhit &> /dev/null; then
								echo "[1mPress [E] For Emergency Mode During Startup, or [F2] to enter setup.[0m"
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
			#					trap _startup_trap DEBUG
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
					test -r ~/.bashrc_noni && source $_
					return;;
			esac
			# }}}

			fi


		#}}}
			# {{{ 	Cache [ faststart(rm) loading ]
			# TODO: use *.environment files to reload additional shells in the same term api, if nothing
			# in bashrc has been touched since their creation
			# TODO: otherwise, flag for rebuilding the environment files (in the background) AFTER the
			#       terminal program (not the shell) exits. This should be non-interactive and disconnected
			# 		  from any TTY or PTS, in otherwords, forked as a daemon
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
				for each in $(cat ~/.config/bashrc/environment/hash | grep -o "^\s*[^#]*"); do
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

		[[ -d $SETLOCAL_SESSION_DIR ]] || mkdir --parents $SETLOCAL_SESSION_DIR

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
		# {{{ EXECUITE HELPER SCRIPT .bash_helpers

		[[ -r ~/.bash_helpers ]] && source ~/.bash_helpers

		# }}}
		fi
		# }}}
		;;&
esac
# }}}
# {{{ END OF TIMED SECTION "PREINIT"
}
# }}}

# }}}
# {{{ ENVIRONMENT VARIABLES

#{{{ MAIN CONFIGURATION
	unset BASH_CONFIG_{ROOTS,DIRS,FILES,RESOURCES}

	declare -xA BASH_CONFIG_ROOTS=(
			 [user]=~/.config/bashrc
			 [shared]=/usr/share/bashrc
			 [sys]=/etc
		 )

	declare -g BASH_CTAGS_FILE=~/tags
	declare -ga BASH_CTAGS_INC=(
	~/.config/bashrc/
	~/.bash*!(*.swp)
	/etc/bash.bashrc
	/etc/bash_completion
	/etc/bash_completion.d/*
	/etc/profile
	/etc/profile.d/*
	/usr/share/bash-completion/bash_completion
	/usr/share/bash-completion/completions/*
	/gxbase/bin/*
	)

	declare -xA BASH_CONFIG_DIRS=(
		[_id]="BASH_CONFIG_DIRS"
		[root]=${BASH_CONFIG_ROOTS[user]}
		[env]=${BASH_CONFIG_DIRS[root]}/environment
		[faststart]=${BASH_CONFIG_DIRS[env]}/faststart
		[flags]=${BASH_CONFIG_DIRS[root]}/flags
		[dev]=${BASH_CONFIG_DIRS[root]}/dev
		[ps1]=${BASH_CONFIG_DIRS[root]}/ps1colors
		[sessionroot]=${BASH_CONFIG_DIRS[root]}/setlocalstack
		[ushell]=${BASH_CONFIG_DIRS[root]}/shells
		)
	declare -xA BASH_CONFIG_FILES=( [_id]="BASH_CONFIG_SWITCHES" [enabled]="true" [experimental_all_features]="false" )
	declare -xA BASH_CONFIG_RESOURCES=( [_id]="BASH_CONFIG_RESOURCES" )

	declare -gx HINTS_COLOR="[38;2;60;60;70m"
	declare -gx DEBUG_MESSAGES_COLOR="[38;2;120;50;60m"
	declare -gx INFO_MESSAGES_COLOR="[38;2;250;120;50m"
	declare -gx WARNINGS_COLOR="[38;2;22;250;42m"
	declare -gx CRITICAL_ERROR_MESSAGES_COLOR="[38;2;250;30;30m"
	declare -gx DETAILED_MESSAGES_COLOR="[38;2;120;255;120m"

	declare -gx DISABLE_HINTS=0
	declare -gx ENABLE_DEBUG_MESSAGES=1
	declare -gx DISABLE_INFO_MESSAGES=0
	declare -gx IGNORE_WARNINGS=0
	declare -gx DISABLE_CRITICAL_ERROR_MESSAGES=0
	declare -gx ENABLE_DETAILED_MESSAGES=1


#{{{ GXBASE
   # put GXBASE's dir in if it exists
	if [[ -z $GXBASE_ROOT ]]; then
		# put in order of most important to least important (system-wide to local user)
		for i in /gxbase /usr/local/gxbase /usr/gxbase ~/gxbase ~/.local/gxbase; do
			if [[ -r $i/startgxbase ]]; then
				if [[ ! $PATH =~ $i ]]; then
					echo "* GxBase Passive Directory Adding To Path: $i"
					PATH+=:$i
					PATH+=:$i/bin
					PATH+=:$i/lib
					PATH+=:$i/core
					# don't use any other, would conflict
					break
				else
					echo "* Gxbase Passive Directory Skipped: $i/* already in path!"
			   fi
			fi
		done
	fi
#}}}
# {{{ cd()

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
# {{{ LOCALE VARIABLES
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
# {{{ CONFIG FILE AND DIRECTORY GLOBALS

	SUDOIZED_FILE=${BASH_CONFIG_DIRS[env]}/sudoized_command_list.rc
	COPROC_FILE=${BASH_CONFIG_DIRS[env]}/coproc_command_list.rc
# }}}
# {{{ KEYBOARD CONSTANTS
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
# {{{ TOGGLES

# force backups (reccommened)
export BASHRC_BACKUPS=ON

# }}}
# {{{ PER-FUNCTION GLOBALS

# {{{ str2which()

FIND_IN_EXTRAS=".:/etc:/etc/init:/etc/default:/etc/init.d:/etc/bash_completion.d:/gxbase/res:/gxbase/bin:/gxbase:~/:~/.config:~/.local"
FIND_IN_EXTRAS+=":/etc/dictd"
FIND_IN_EXTRAS+=":/etc/alternatives"
FIND_IN_EXTRAS+="$(echo \"${BASH_CONFIG_DIRS[@]}\" | sed 's/\n/:/g')"

#}}}

#}}}

#}}}
# {{{ HISTORY (HIST CONTROL/SIZE/FILESIZE vars)
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=200000
# }}}
# {{{ DEFAULT PROMPT (PS1, PS2 and PS3 - for main prompt, more output prompt, select menu prompt, respectively)
PS1='lv$[SHLVL-2] r$? \[\e[38;5;$[$?+2]m\]\u@\h \[\e[38;5;$[${#PWD}+32]m\]\w\[\e[40;30;1m\] \$\[\e[0m\] '
PS2='\[\e[30;1m\]more\[\e[36;1m\]?\[\e[0m\] '
PS3='selection:' # NOTE, IMPORTANT!!: PS3 does not get evaluated like PS1/PS2 so embedded codes make no difference (or execution of $()s either)
# }}}
# {{{ SAVE STARTING DIRECTORY (WHERE BASH INVOKED FROM), FIND A TEMPORARY DIRECTORY LOCATION

declare -gx BASH_STARTUP_PWD=$PWD
declare -gx GTMP=$(dirname `mktemp -u`)

if touch $GTMP; then
	: # nop--dont remove the :
elif touch /var/tmp; then
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
declare -gx GITDSITE=${GTMP}/gitdummy_$(id -g)_$UID


# so we dont have to keep running /usr/bin/tty
if tty -s; then
	# TODO: investigate that the TTY lock can be altered after an exec(2) or fork(2)
	#       resolved (in part): added check for readonly here and above (in check for interactive)
	declare -gx TTY=$(tty)
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
# {{{ ls (LS_COLORS, uses .dircolors)
	if [[ -x `which dircolors` ]]; then
		if [[ -r ~/.bash_dircolors.db ]]; then
			eval "$(dircolors -b ~/.bash_dircolors.db)"
		elif [[ -r ~/.dircolors ]]; then
			eval "$(dircolors -b ~/.dircolors)"
		else
			eval "$(dircolors -b)"
		fi
	else
		echo "Warning: binary dircolors not in path, no LS_COLORS will be ${DIRCOLORS+re}set!"
	fi

#}}}

# }}}

# }}}
# {{{ PROGRAMMABLE COMPLETION

# {{{ INIT COMPLETION
	shopt -s nullglob
	# forward declarations
	slice_func __isflag
	slice_func __validflagname
# }}}
# {{{ FUNCTIONS
# {{{    _initshow() --- preloader for show() command (in turn, preloads man and apt-cache)
function _initshow()
{
	# load completions needed by this command
	_completion_loader apt-get
	_completion_loader apt-cache
	_completion_loader man
	# set real completions up
	complete -A variable -A binding -A function -A alias -A user -A variable -A file -A directory -F _man -A builtin -A arrayvar show
	# this function not needed, unloading it to save memory
   unset -f $FUNCNAME
}
# }}}

# }}}
# {{{ PARSE COMPLETIONS
# (for completions that are on ramdisk or high-draw shells)
if __isflag COMPLETE_ALL_BINARIES; then
	if [[ -r ~/.config/bashrc/flags/complete_all_binaries ]]; then
		echo "* applying completion to ALL binaries (this will take a minute or two!)"
		shopt -s nullglob
		for i in /usr/bin/* /bin/* /usr/sbin/* /sbin/* /usr/local/bin/* /usr/local/sbin/*; do
			complete -F _longopt $(basename $i)
		done
		shopt -u nullglob
		echo "* completions have been loaded"
	fi

fi

#_completion_loader ()
#{
#    local compfile=./completions;
#    [[ $BASH_SOURCE == */* ]] && compfile="${BASH_SOURCE%/*}/completions";
#    compfile+="/${1##*/}";
#    [[ -f "$compfile" ]] && . "$compfile" &> /dev/null && return 124;
#
#    if __isflag NO_LONGOPT_BY_DEFAULT_COMPLETION || MYVAL=`whereis bash -m | grep '(?<= |^)[^ ]*.[168](\.gz)?(?= |$)' --max-count=1 -o`; then
#	if zcat -f "$MYVAL" | grep -- '--[-a-z]+' -Pq; then
#		complete -F __longopt "$1" && return 124
#	fi
#  else
#   		complete -F _minimal "$1" && return 124
#   fi
#}


# needed by 'show'

#complete -F _dlgopt dialog
#complete -F _longopt locate
#complete -F _longopt ddd
#complete -F _longopt ctags
#complete -F _longopt ctags-exuberant
#complete -F _longopt ./configure
#complete -F _longopt chmod
complete -A variable -A arrayvar __xlatv
complete -F _initshow show
complete -F _initshow defined
#complete -D _completion_loader



# nullglob MUST be off, or completion will NOT work on the command line
shopt -u nullglob


# }}}
#{{{ EXTENDED COMPLETIONS
   # only load our completions if globals are not available (who should have already loaded ours normally)
	# needed in case system admins change or remove completion from bash config files (like /etc/bash_completion)
	[[ _completion_loader != $(declare -F _completion_loader) ]] &&  [[ -r ~/.bash_completion ]] && source ~/.bash_completion
	complete -F _debconf_show src 	# for the src() function
   complete -F _longopt dialog

#}}}

#}}}
#{{{ EXTRA SOURCES
# use sources loader config/sources
source ${BASH_CONFIG_DIRS[root]}/sources
#}}}
#{{{ USER ALIASES

# {{{ Sudoized

# first use and example: check current row, move up if at the last line
# move up by one, if at the last

slice_func _cur_row
declare -i ROW=`_cur_row`; [[ $ROW -ge $ROWS ]] && tput cuu 3

echo -n "* Sudoized Commands: "
if [[ $UID -ne  0 ]] && groups | grep -Pq sudo; then
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
				echo "(This message will self-destruct.)"
		  	fi
			unset -f $FUNCNAME
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
					eval "function ${item}() { command $item \"\$@\" & }"
					;;
				disowned) # run in background, but dont keep in job list
						eval  "function ${item}() { command $item \"\$@\" & disown; }"
					;;
				silent) # run in background, without any output
					eval "function ${item}() { command $item \"\$@\" > /dev/null 2>&1 & }"
					;;
				ignored) # run in background, removed from joblist, and no output (aka pseudo-daemonize)
					eval "function ${item}() { command $item \"\$@\" > /dev/null 2>&1 & disown; }"
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
	unset -f $FUNCNAME
}; proc_co

# }}}
#{{{ Hardcoded Conditional

if [[ $TTY != NONE ]]; then
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto -P'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias lb='clear; exec /usr/bin/bash; true'
	alias ls='ls -lh --color'
	alias du='du -h --max-depth=1'
	alias df='df -h --total `lsblk | grep -Po "(?<=part )/\S*" | tr "\n" " "` | colorit'
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'

	# __perdiralias(full_pathname)
	# hooked to cd, defines (undefines) aliases depending on their location in the filesystem
	# this does NOT include shell extensions that use their own binary (like perlconsole or aptsh)
	# this DOES include shell extensions that use bash at the same interaction level (like git.bashrcshell (gitsh))
	# binary shells cant use this because they are not bash shells, however, they can still be set for them
	# and if the binary chooses to look at BASH_ALIASES, it WILL have access to them. At this point the only
	# use for this is for developers who work directly with gxbase and bashrc-gxbase.
	# arguments
	# ---------
	#    full_pathname 		a non-relative path to the target directory. This is not a symbolic link, links are resolved BEFORE the call!
	#                       some pathnames are reserved for shell integration (see note on that above).
	function __perdiralias()
	{
		local TARGET="${*: 0:1}"; shift
		local SUBDIRS=( */ )

		{
			case $TARGET in
				*)	# all directories - INCLUDING those who have had their own processors below
					alias whereami='echo "processed dir: $PWD"'
					;&

				*) # all directories - EXCEPT for those who have had special processing above
					alias whereami='echo "unprocessed dir: $PWD"'
					;;
			esac
		}


	}

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

# }}}
# {{{ BASH COMPLETION

# {{{ LOAD SYSTEM-WIDE COMPLETION FILES
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if shopt -oq posix; then
	echo "Warning: posix-compatibility mode has been enabled, please check your startup scripts."
else
  if [[ ! -r /etc/bash.bashrc ]] || ! grep bash_completion /etc/bash.bashrc -Pq; then
	  if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
		 source "/usr/share/bash-completion/bash_completion"
	  elif [[ -f "/etc/bash_completion" ]]; then
		 source "/etc/bash_completion"
	  fi
  fi
fi
# }}}

# }}}
# {{{ FUNCTIONS (PROGRAM, CATEGORIAL, A-Z)


#### MINI PROGRAMS

# {{{ Setup Program (the main feature of the script (soon to be)
function setup-bashrc()
{
	if ! which dialog &> /dev/null; then
		echo "The setup program requires the 'dialog' package, which you do not have. Please install dialog to use this feature!"
	else
		# prevent intervention
		trap DEBUG
		trap : SIGTSTP
		trap : SIGSTOP
		trap : SIGINT
		# kill cleanup
		trap 'setup-bashrc-cleanup' SIGKILL
		test -r ~/.config/bashrc/shells/setup.bashshell && source ~/.config/bashrc/shells/setup.bashshell
		# cleanup if we didnt get killed
		defined function setup-bashrc-cleanup && setup-bashrc-cleanup
	fi
}
# }}}


#### CATEGORIAL

# {{{ Trap Hooks - !! EXPERIMENTAL !! __BASH_EXT_HOOK() and related functions !! EXPERIMENTAL !!

# {{{    __BASH_EXT_HOOK() - main hook proc for signal use
function __BASH_EXT_HOOK()
{
	# set locals (the signal's name and it's hooks, if declared)

	unset SIGHOOKS SIGNAL SIGHOOK_NAME

	local SIGNAL=$1
	local SIGHOOK_NAME=${SIGNAL}_HOOKS
	if [[ ! -v $SIGHOOK_NAME ]]; then
		return
	fi
	echo "SIGNAL NAME: $SIGNAL_NAME"
	declare -n SIGHOOKS=${SIGNAL_NAME}
	# echo signal if flagged
	[[ -v BASHRC_FLAG_NOTIFY_ON_SIGNALS ]] && { echo "Signal Catch $FUNCNAME : $1 : ${*: 2}"; }
	# call hooks for this signal, if any
	# (they must be either single or arrayed)
	if [[ $(declare -p $SIGHOOK_NAME) =~ .*(-a|--).* ]]; then
		if [[ ${#SIGHOOKS[@]} -ge 1 ]]; then
			for signalhook in "${SIGHOOKS[@]}"; do
				if [[ $(declare -f $signalhook) == $signalhook ]]; then
					$signalhook "$@"
				else
					[[ -v BASHRC_FLAG_NOTIFY_ON_SIGNAL_MAPERRORS ]] && echo "Signal map error: hook $signalhook is not a bash callable function"
				fi
			done
		else
			[[ -v BASHRC_FLAG_NOTIFY_ON_SIGNAL_MAPERRORS ]] && echo "Signal map error: hook variable $SIGHOOK_NAME is empty or undefined, it must be a nonexported indexed array or single variable that contains a function name or array of names."
		fi
	else
		[[ -v BASHRC_FLAG_NOTIFY_ON_SIGNAL_MAPERRORS ]] && echo "Signal map error: hook variable $SIGHOOK_NAME must be a nonexported indexed array or single variable that contains a function name or array of names."
	fi

}; declare -tf __BASH_EXT_HOOK
# }}}
# {{{    __BASH_RELOAD_HOOK() - user hook called by vim
function __BASH_RELOAD_HOOK()
{
	declare -xi BASH_KEY_RESOURCING=1
   source ~/.bashrc
	unset BASH_KEY_RESOURCING
}; declare -tf __BASH_RELOAD_HOOK

#}}}
function __push_traps()
{
	:
}; declare -tf __push_traps

function __pop_traps()
{
	:
}; declare -tf __pop_traps

function __clear_traps()
{
	for trapname in `compgen -A signal`; do
		[[ $trapname =~ (SIGTTOU|SIGTTIN|SIGTSTP) ]] ||	trap $trapname
	done
}; declare -tf __clear_traps

function __untrap()
{
	# doent do much, its made for clarity's sake
	# however, you can use the IDENTICAL trap call to untrap, and it will work
	# example: trap 'somecmd()' DEBUG <- binds DEBUG signal to somecmd()
	#        untrap 'somecmd()' DEBUG <- same as 'trap DEBUG' which effectively untraps the DEBUG signal
	# uses: use for simplifying trap/untrap calls in the same loop without reorganizing parameters.
	[[ -v LAST_TRAP ]] || declare -gA LAST_TRAP=( ZERO="/dev/null" )
	LAST_TRAP[${*: -1}]=`trap -p "${*: -1}"`
	trap "${*: -1}"
	set +ET
}; alias untrap='set -ET; __untrap'; declare -tf __untrap



# }}}
# {{{ SHELL BUILTINS' DELEGATORS *

# note* previously known as "super builtins"
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
			[[ $OLDGS != $INGIT ]] && source ~/.config/bashrc/shells/git/git.bashrcshell
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
			#{{{ Set GIT Mode Off, and Reload git.bashrcshell so it can unload it's stuff itself (must be gxbase patched one)
			GITSPECIAL=UNSET
			[[ $OLDGS != $INGIT ]] && source ~/.config/bashrc/shells/git/git.bashrcshell
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
# }}}
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
# {{{  command not found
function __bashrc_ext_command_not_found_handler()
	{
		if [[ -v IN_CNFH_PROC ]]; then
			return
		fi
		declare -g IN_CNFH_PROC=1
		# CNFH multi-hook support
      # execute any hooks
		if [[ -v CNFH_EXT_HOOKS ]]; then
			# check to make sure it's either an indexed array OR a single variable
			# they can NOT be readonly, global, etc [for security's sake]
			if [[ $(declare -p CNFH_EXT_HOOKS) =~ ^[a-r]{7}' '[-a]{2} ]]; then
				for hook in "${CNFH_EXT_HOOKS}"; do
					# verify callable function
					[[ $(declare -F $hook) == $hook ]] && $hook "$@" || {	[[ -v CNFH_HOOK_WARNINGS_FLAG ]] &&	echo "Warning: $hook uncallable hooktable entry in CNFH_EXT_HOOKS"; }
				done
			else
				[[ -v CNFH_HOOK_WARNINGS_FLAG ]] && echo "Warning: CNFH_EXT_HOOKS must be an indexed array or a single variable with no attributes (not exported, readonly, etc)."
			fi
		else
			[[ -v CNFH_HOOK_WARNINGS_FLAG ]] && echo "Warning: CNFH_EXT_HOOKS not defined and CNFH_HOOK_WARNINGS_FLAG is defined (undefine it to disable this message)."
		fi
		# prevent non-ineractive commands from doing this (or null ttys)
		# uncomment these lines if you really need this kind of support
		# (this WILL slow it down a bit especialy when debugging scripts!)
		case $- in
			*i*)
				case `tty` in
					*tty*|*pts*)
						echo "Command Not found: $*"
					  	;;
					*)
						return
						;;
				esac

				;;
			*)
				return $?
				;;
		esac
		# TODO: make a session-specific flags dir, and put these here
		#       to do that, we'll need session-storage/session-load/save routines in place first.
		[[ -r ~/.config/bashrc/flags/ALWAYS_CHECK_SESSION ]] && local ALWAYS_CHECK_SESSION=y
		[[ -r ~/.config/bashrc/flags/ALWAYS_INSTALL_SESSION ]] && local ALWAYS_INSTALL_SESSION=y
      [[ -r ~/.config/bashrc/flags/NEVER_CHECK_SESSION ]] && local ALWAYS_CHECK_SESSION=n
		[[ -r ~/.config/bashrc/flags/NEVER_INSTALL_SESSION ]] && local ALWAYS_INSTALL_SESSION=n

		# prevent overwriting of the global or other local $REPLY that might be out there
		local REPLY=""
		# you could set these permanantly to y, if you want it to persist (not recommened!)
		if [[ $ALWAYS_CHECK_SESSION == y ]]; then
			# behave like default cnh (this is the default)
			REPLY=y
			echo "$* Not Found, Checking for possible match... (user forced 'always check')"
		elif [[ $ALWAYS_CHECK_SESSION == n ]]; then
			# behave like built-in cnh (no further information given)
			return 127;
		else
			# prompt (interactive only, user defines this behavior)
			echo -ne "Want to check [enter or N=skip, Y=check, A=always/session] ? "
			read -sn1
			if [[ $REPLY =~ [Aa] ]]; then
				REPLY=y
				touch ~/.config/bashrc/flags/ALWAYS_CHECK_SESSION
			fi
		fi

		if [[ $REPLY =~ [Yy] ]]; then
			if [[ -x "/usr/lib/command-not-found" ]]; then

				echo "Searching database for this program..."
				RESULT=`/usr/lib/command-not-found "$@" 2>&1`
				echo "$RESULT"
				if INSTALL_RESULT=`echo "$RESULT" | grep "(apt-get|sudo apt-get).*"`; then
					if [[ $ALWAYS_INSTALL_SESSION == y ]]; then
						# be agressive and install, only for those who know what they are doing
						# usually you will have this on for the first week of a newly installed
						# system, just to get commands reinstalled that you expect to be there
						# NOT RECOMMENDED for long-term use!!
						REPLY=y
						echo "Single Install Found, Starting Installer... (user forced 'always install')"
					elif [[ $ALWAYS_INSTALL_SESSION == n ]]; then
						# behave like normal cnh at this point (this is the default behavior)
						# recommended setting
						return 127;
					else
						# prompt (interactive only, udtb)
						echo -ne "Want to Install? [enter or N=no, Y=install, A=always/session] "
						read -sn1
						if [[ $REPLY =~ [aA] ]]; then
							REPLY=y
							touch ~/.config/bashrc/flags/ALWAYS_INSTALL_SESSION
						fi
					fi
					if [[ $REPLY =~ [yY] ]]; then
						echo "Attempting install..."
						# this will allow for sudo to be added if the user can do so
						if INSTALL_COMMAND=( `echo $RESULT | grep '(sudo )?apt-get.*'` ); then
							# the quotes are essential
							"${INSTALL_COMMAND[@]}"
						else
							# this happens when the user is 1) not root AND 2) not a sudo permissive/member
							echo "Error: install not possible! Please contact your system administrator!"
							# ensure error state $?=1
							(exit 1)
						fi
						local INSTALL_RESULT=$?
						if [[ $INSTALL_RESULT -eq 0 ]]; then
							echo "Succeeded, re-invoking original command line..."
							# again, quotes are needed to retain original command line!
							"$@"
						else
							echo "install completed with code $INSTALL_RESULT"
						fi
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
		### IMPORTANT: Do NOT let any branch return before exiting this next line
		unset IN_CNFH_PROC
	}
	#}}}
# }}}
# {{{ SHELL COMMAND DELEGATORS *

# note* - aka 'super commands' or 'commands' in previous versions

# {{{    cat() [cat args] [filename] : colorizing cat via /etc/dictd/colorit.conf
function colorcat()
{
	command cat "$@" | colorit
}
# }}}
# {{{ install() - combines '/usr/bin/install' and '/usr/bin/apt-get install' for interactive use
function install()
{
	local RETV=$?
	if ! __isflag DISABLE_SUPERCMD_INSTALL; then
		DEBM "install: supercmd disabled (DISABLE_SUPERCMD_INSTALL), running install normally [per session notice!]"
		HINT "unset the DISABLE_SUPERCMD_INSTALL before first call to use this feature again"
		command install "$@"
		RETV=$?
		unset -f $FUNCNAME
		DEBM "DISABLE_SUPERCMD_INSTALL: install returned $RETV, and UNSETTING install(), install will run directly for the remainder of this session!"
		HINT "(disable debug messages by unsetting ENABLE_DEBUG_MESSAGES or setting it to \"0\", or manipulating it's flag)"
		return $RETV
	else
		if [[ "$BASH_SOURCE" == "" && "${#BASH_SOURCE[@]}" ]]; then
			DETA "BASH_SOURCE defined, which means this is a script, passing to regular program 'install'"
			command install "$@"
		else
			DETA "install called by user directly, using sc install..."
			INFO "$(date) $SECONDS Checking for valid apt-get install command line..."
			local S1=$SECONDS
			if apt-get install -s "$@" &> /dev/null; then
				INFO "Command Completed OK, Proceeding with Install [follow prompts as needed]..."
				apt-get install "$@"
			else
				WARN "not a valid command line for apt-get, passing it to 'install'..."
				if ! command install "$@"; then
					CRIT "Not a valid install command either, the return code was: $?"
				else
					INFO "install command: success ($?)"
				fi
			fi
			local S2=$SECONDS
			INFO "$(date) $SECONDS Installer Cycle Completed in $[ $S2 - $S1 ] second(s)."
		fi
		RETV=$?
		DEBM "Finished handler install($RETV)"
		return $RETV
	fi

}

# }}}
#{{{     systemsettings() -- console-mode (ncurses) control panel for kde's system settings (kde4+ required)
function systemsettings()
{
	if ! tty -s || [[ ! -x /usr/bin/kcmshell4 ]] || [[ $KDE_FULL_SESSION != true ]] || [[ $KDE_SESSION_VERSION -lt 4 ]] || [[ $KDE_SESSION_UID -ne $UID ]]; then
		local USETTY=0
	else
		local USETTY=1
	fi



	if [[ $USETTY == 1 ]]; then
		while true; do
		  	(IFS='|'; myvar=( $(kcmshell4 --list | tail -n+2 | perl -le 'for (<>) { s/^(\S+)\s+-\s+(\S.*)$/\1\|\2\|/g; chomp $_; print $_; }; printf "Cancel\|Exit"' | tr -d '\n') ); unset IFS; dialog --menu "KDE Options" 0 0 0 "${myvar[@]}") 2> response; response=`cat response`; [[ $reponse == "" ]] || [[ $? -ne 0 ]] && break; kcmshell4 $response;
		done
	else
		command `which systemsettings` "$@"
	fi
}
#}}}
# {{{ vim - old vim code (renamed to vim_old) and functions related to it/used by it
#{{{     vim_old [vim-compatible command line] (only expands search for files and induces sudo if needed): RV: vim's return code
function vim_old()
{
	if [[ $* =~ --[a-z] ]] || [[ $* =~ ( |^)-[a-z]( |$) ]]; then
		DEBM "flags were given, direct mode selected!"
		 __isflag AUTO_GVIM && GV=g$FUNCNAME || GV=$FUNCNAME
		 command vim "$@"
		return $?
	else

	cat <<-EOF | WARN $(cat /dev/stdin)
		vim smartlauncher(tm) v0.0.2
		(C)2013-14 Paradisim LLC, Gabriel T. Sharp <osirisgothra@hotmail.com>
		homepage: http://paradisim.github.com/gxbase-extras-vimsl.git
	EOF


	fi

	# done here, since we dont want to use until we first use them
	if ! vim_settings; then
		echo "Loader Stopped: vim_settings was unable to set up the required variables"
		echo "Pass command line directly? (vim $*)"
		if [[ `read -sn1; echo ${REPLY^^}` == 'Y' ]]; then
			vim "$@"
		else
			false
		fi
		return
	fi
	# FAILSAFE PASSED
	# UNLOADABLES are variables that can be cleaned up by the garbage collector using the _g_collect
	# this helps to conserve memory for the environment
	if [[ ! -v UNLOADABLES ]]; then
		declare -ga UNLOADABLES
		UNLOADABLES+=( SUDO_EXECUTABLE VIM_EXECUTABLE )
	fi
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
			vim_command "$SUDO_EXECUTABLE" -- "$VIM_EXECUTABLE" "${VIM_SERVER_COMMAND_LINE[@]}" "$@"
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
		DETA "Launching command line: command $VIM_EXECUTABLE \"$@\""
		vim_command "$VIM_EXECUTABLE" "${VIM_SERVER_COMMAND_LINE[@]}" "$@"
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

# {{{    vim_command() -- as in a regular vim command - checks for server / remote before apply server commands
function vim_command()
{
	"$@"
}
# }}}
#{{{     vim_settings() - sets up environment for the vim() function, not meant to be called from the command line!
function vim_settings()
{
	# attempt the use of the server whenever possible
	if __isflag VIM_DISABLE_SERVER; then
		INFO "Server (single-instance) Mode for VIM is disabled."
		HINT "Declare VIM_DISABLE_SERVER=1 -or- move the VIM_DISABLE_SERVER flag into the active 'flags' directory"
		if [[ -v VIM_SERVER_COMMAND_LINE ]]; then
			DEBM "VIM_SERVER_COMMAND_LINE: with previous value of $VIM_SERVER_COMMAND_LINE is now UNSET"
			unset VIM_SERVER_COMMAND_LINE
			read
		else
			DEBM "VIM_SERVER_COMMAND_LINE: already unset, no action taken"
		fi
	else
		unset VIM_SERVER_COMMAND_LINE
		unset VIM_SERVER_LIST
		declare -agx VIM_SERVER_LIST=( `/usr/bin/vim --serverlist` )
		for server in "${VIM_SERVER_LIST[@]}"; do
			DEBM "Located Server $server"
			if [[ $server == GXBASE_VIM_INSTANCE ]]; then
				FOUND_SERVER=$server
			fi
		done
		if [[ $FOUND_SERVER != GXBASE_VIM_INSTANCE ]]; then
			declare -agx VIM_SERVER_COMMAND_LINE=( "--servername" "GXBASE_VIM_INSTANCE" "--remote" )
			DEBM "VIM_SERVER_COMMAND_LINE: now is set to: ${VIM_SERVER_COMMAND_LINE[@]}"
			DEBM "VIM_SERVER_COMMAND_LINE: will be used in the calls to vim() that launch vim AFTER this point."
      elif [[ ${#VIM_SERVER_LIST[@]} -gt 0 ]]; then
			SVRMSG="Our server isn't running, but there are others, would you like to use one?"
			bmenu "$SVRMSG" `for i in @{VIM_SERVER_LIST[@]}; do echo \"$i|$i\"; done`
			response=$?
			if [[ $reponse -gt 0 && $response -lt 255 ]]; then
				declare -agx VIM_SERVER_COMMAND_LINE=( "--servername" "${VIM_SERVER_LIST[$response]}" )
			else
				unset VIM_SERVER_COMMAND_LINE
			fi
		else
			unset VIM_SERVER_COMMAND_LINE
		fi
	fi
	# make empty if not defined -- so it wont complain -- send a message about it
	[[ -v VIM_SERVER_COMMAND_LINE ]] || { declare -g VIM_SERVER_COMMAND_LINE="" && DETA "No VIM Server Will Be Used This Session"; }
	DEBM "VIM_SERVER_COMMAND_LINE parsing finished, moving on..."
	DEBM "VIM_EXECUTABLE setup in progress..."
     if [[ ! -x $VIM_EXECUTABLE ]]; then
			# works in this life, not the next (might not be same mode)
			declare -g VIM_EXECUTABLE
			if [[ $TERM =~ (cons|linux) ]]; then
				VIM_EXECUTABLE=`which vim`
			else
				if can_execute_x_progs; then
					if __isflag AUTO_GVIM; then
						INFO "Launching [gvim] since X is available, remove the AUTO_GVIM flag to disable this feature."
						if ! VIM_EXECUTABLE=`which gvim`; then
							VIM_EXECUTABLE=`which vim`
						fi
					else
						VIM_EXECUTABLE=`which vim`
						HINT "Hint: X is running, you can set the AUTO_GVIM config flag to use it by default!"
					fi
				fi
			fi
			if [[ -x $VIM_EXECUTABLE ]]; then
				INFO "VIM Executable chosen: $VIM_EXECUTABLE"
			else
				CRIT "ERROR: vim not detected, you must have vim/gvim in your path to use it!"
				return 1
			fi
		fi

		if [[ ! -x $SUDO_EXECUTABLE ]]; then
			# sudo mode
			declare -g SUDO_EXECUTABLE
			local -a SUDO_PROGS=(`which kdesudo` `which gksudo` /etc/alternatives/*sudo* `which sudo`)
			for sudoprog in "${SUDO_PROGS[@]}"; do
				if [[ -x $sudoprog ]]; then
					echo "Selected Sudo Program: $sudoprog"
					SUDO_EXECUTABLE=$sudoprog
					break
				fi
			done
			if [[ ! -x "$SUDO_EXECUTABLE" ]]; then
				echo "ERROR: sudo not in path, you will NOT be able to use sudo (elevated privs) when editing!"
			fi
		fi
		DETA "Selected $SUDO_EXECUTABLE and $VIM_EXECUTABLE for handling the vim command!"
		HINT "You can change these anytime to your own values!"

}
#}}}
# }}}
# {{{ vim (new vim() and related functions)
alias pval='exec 2>/tmp/perloutput; perl -we <<-"pval end" #'
alias pvvr='exec 2>/dev/stdout; mapfile PERLOUTPUT < /tmp/perloutput; rm /tmp/perloutput'
# {{{ hrule(CHAR,COUNT,PREFIX,SUFFIX)
function __hrule()
{
	[[ $COLUMNS ]] || [[ -x `which resize` ]] && eval `resize`
	local RETAINED_EXITCODE=$?
	local PREFIX="$3"
	local SUFFIX="$4"
	local CHAR="$1"
	local COUNT="$2"
	[[ $CHAR ]] || CHAR="-"
	[[ $PREFIX ]] || PREFIX=$CHAR
	[[ $SUFFIX ]] || SUFFIX=$CHAR
	[[ $COLUMNS ]] || COLUMNS=50
	[[ $COUNT && $COUNT -ge $(( ${#CHAR}+${#PREFIX}+${#SUFFIX} )) ]] || COUNT=$((  ( $COLUMNS - ${#PREFIX} - ${#SUFFIX} ) / ${#CHAR} ))

	printf "%s" "$PREFIX"
	eval printf -- "$CHAR%0.0s" {1..$COUNT}
	printf "%s\n" "$SUFFIX"
	return $RETAINED_EXITCODE;
}
# }}}
# {{{ vim() -- hook
function vim()
{
	if __isflag NO_VIM_OVERRIDES; then
		if __isflag NO_LIVE_STUBS; then
			slice_func vim_stub
		fi
		vim_stub "$@"
	else
		command vim "$@"
	fi
}
# }}}
# {{{ vim_stub() -- stub - live "prevalant" handler
function vim_stub()
{

	# scalars
	local VIM_EXEC GVIM_EXEC SUDO_EXEC USE_SUDO USE_GVIM VIM_SERVER GVIM_SERVER SUDO_REQUIRED SUDO_SUGGESTED USE_SUDO_IN_CMD;
	# ordered arrays
	local -a VIMARGS=( )
	local -a VIM_SERVER_LIST=( )
	local -a VIM_SERVER_LIST_PRE=( )
	local -a V_S_L

   VIM_EXEC=`which vim`
	GVIM_EXEC=`which gvim`
	SUDO_EXEC=`which sudo`
	# IMPORTANT NOTE: vim servers MUST BE IN UPPERCASE (they get converted to that regardless of case, this is yet another Win32 curse snuck in)
	USE_SUDO=$( [[ $UID -eq 0 ]] && echo 0 || { groups | grep sudo -q && echo 1 || echo 0; } )
	USE_GVIM=$( __isflag AUTO_GVIM && echo 1 || echo 0 )
	VIM_SERVER="VIM_LEVEL${USE_SUDO}_SERVER_${UID}_$GROUPS"
	GVIM_SERVER="GVIM_LEVEL${USE_SUDO}_SERVER_${UID}_$GROUPS"
	VIM_SERVER_LOOKUPLIST=( $VIM_SERVER $GVIM_SERVER )
	VIM_SERVER_LIST_PRE=( `/usr/bin/vim --serverlist` )
	if __isflag MIXING_VIM_AND_GVIM_SERVER_NAMES_OK; then
		VIM_SERVER_LIST=( "${VIM_SERVER_LIST_PRE[@]}" )
	else
		for i in ${VIM_SERVER_LIST_PRE[@]}; do
			if ((USE_GVIM)); then
				if [[ ${i^^} =~ GVIM ]]; then
					VIM_SERVER_LIST+=( "$i" )
				fi
			else
				if ! [[ ${i^^} =~ GVIM ]]; then
					VIM_SERVER_LIST+=( "$i" )
				fi
			fi
		done
	fi
	VIM_SERVER_RUNNING=$(( ${#VIM_SERVER_LIST[@]} != 0 ))   # emphasis on final level: [math] '='$((' not [list] '=('
	SUDO_REQUIRED=0
	SUDO_SUGGESTED=0
	USE_SUDO_IN_CMD=0
	VIM_SERVER_TO_USE=NONE
	VIM_SERVER_TO_FIND=${VIM_SERVER_LOOKUPLIST[$USE_GVIM]}
	VIM_SERVER_INTERACT=$( __isflag NO_VIM_SERVERS && echo 1 || echo 0 )

	if [[ $VIM_SERVER_INTERACT == 1 ]]; then
		if [[ ${#VIM_SERVER_LIST[@]} > 0 ]]; then
			for i in "$VIM_SERVER_LIST"; do
				case $i in
					"$VIM_SERVER_TO_FIND")
						VIM_SERVER_TO_USE="$i"
						break;;
				esac
			done
			if [[ $VIM_SERVER_TO_USE == NONE ]]; then
				if dialog --yesno "Couldn't locate any trusted vim server. There are OTHER servers running, would you like to connect to one?" 0 0; then
					if RESPONSE=`dialog --no-tags --output-fd 1 --menu "Please Pick A Server" 0 0 0 $( for j in "$VIM_SERVER_LIST"; do echo -ne " $j $j "; done )`; then
						VIM_SERVER_TO_USE="$RESPONSE"
					fi
				fi
			fi
		else
			if dialog --yesno "No vim servers are running, create one now?" 0 0; then
				VIM_SERVER_TO_USE="$VIM_SERVER_TO_FIND"
			fi
		fi
	else
		HINT "VIM Servers are disabled (NO_VIM_SERVERS flag has been set), you can enable them by getting rid of the flag!"
	fi
	DEBM "Phase: untainting (scrubbing) arguments -- $@"
   for i in "$@"; do
		if [[ $i =~ ^--(remote|time|help|\?|version|server|start|$) ]]; then # the |$) part is because we dont want -- being passed to bypass switch operation (will screw up us)
			echo "skipping illegal parameter: $i (eaten by this function)"
			continue
		elif [[ $i =~ ^--?[-a-zA-Z0-9]*$ ]]; then
			echo "preserving parameter flag: $i"
			NEXT="$i"
		else
   		NEXT=$(switch_which_text $i)
			if [[ -e "$NEXT" && -f "$NEXT" ]]; then
				if [[ -r "$NEXT" && -w "$NEXT" ]]; then
					echo "file found that was read/writable by uid $UID, no sudo tripped here"
				else
					echo "file $NEXT is not read/writable (or both) by uid $UID, sudo needed tripped"
					SUDO_REQUIRED=1
				fi
			else
				if [[ -d "$NEXT" ]] && [[ ! -r $NEXT || ! -w $NEXT || ! -x $NEXT ]]; then
					echo "directory $NEXT is not read/write/executable by $UID, should be sudo, tripping suggest"
					SUDO_SUGGESTED=1
				else
					echo "directory r/w/x ok by current uid, $UID, no trip needed on suggest sudo"
				fi
			fi
		fi
		VIMARGS+=( "$NEXT" )
	done
	DEBM "Phase: adding appropriate items to command line based on settings"
   if [[ $VIM_SERVER_TO_USE != NONE ]]; then
		if __isflag VIM_SILENT_FAIL_SERVER_OPS; then
			local VIMARG_REMOTESTR='--remotesilent'
		else
			local VIMARG_REMOTESTR='--remote'
		fi
		VIMARGS=( --servername "$VIM_SERVER_TO_USE" "$VIMARG_REMOTESTR" "${VIMARGS[@]}" )
	fi
	if (( USE_GVIM )); then
		VIMEXEC="$GVIM_EXEC"
	else
		VIMEXEC="$VIM_EXEC"
	fi
	if (( USE_SUDO )); then
		if (( SUDO_REQUIRED )); then
			USE_SUDO_IN_CMD=1
		elif (( SUDO_SUGGESTED)); then
			if dialog --yesno "One of the directories in the command line cannot be used by user $USER($UID). This user has permissions to use sudo, would you like to enable it?" 0 0; then
				USE_SUDO_IN_CMD=1
			else
				USE_SUDO_IN_CMD=0
			fi
		else # not REQUIRED nor SUGGESTED
			USE_SUDO_IN_CMD=0
		fi
	else # cant sudo anyways so dont ask/pretend this feature doesnt exist! (but warn)
		(( SUDO_REQUIRED && SUDO_SUGGESTED != 1 )) && WARN "$@ : read/write not possible on some arguments' file components"
		(( SUDO_REQUIRED != 1 && SUDO_SUGGESTED )) && WARN "$@ : read/wr/ex not possible on some arguments' directory components"
		(( SUDO_REQUIRED == 1 && SUDO_SUGGESTED )) && WARN "$@ : read/wr/ex not possible on arguments' file and directory [separate] components"
		USE_SUDO_IN_CMD=0
	fi
	echo "server to use at this point: ${VIMARGS[@]}"

	if (( USE_SUDO_IN_CMD )); then
		VIMARGS=( "$SUDO_EXEC" "$VIMEXEC" "${VIMARGS[@]}" )
	else
		VIMARGS=( "$VIMEXEC" "${VIMARGS[@]}" )
	fi
	DEBM "Phase: display pre-launch statistics to user"

cat <<-EOF | sed "s/HRULE/$(__hrule)/g;s/\n//g"
		[31;1mVim Launcher Statistics
		[1;30mHRULE
		[33;1mREQUIREMENTS     [33;1mState (0=no/off 1=yes/on)
		[32;1mSUDO_REQUIRED    [34;1m$SUDO_REQUIRED [doesn't affect USE_SUDO]
		[32;1mSUDO_SUGGESTED   [34;1m$SUDO_SUGGESTED [ditto]
		[32;1mUSE_SUDO_IN_CMD  [34;1m$USE_SUDO_IN_CMD [final call for sudo's use]
		[32;1mVIM_S..R_RUNNING [34;1m$VIM_SERVER_RUNNING (any servers running?)
		[30;1mreserved         [30;1m-
		[30;1m                 [30;1m
		[33;1mEXECUTABLES      [33;1mPath/Executable
		[32;1mVIM_EXEC         [34;1m$VIM_EXEC
		[32;1mGVIM_EXEC        [34;1m$GVIM_EXEC
		[32;1mSUDO_EXEC        [34;1m$SUDO_EXEC
		[33;1mSETTINGS         [33;1mState (0=no/off 1=yes/on)
		[32;1mUSE_SUDO         [34;1m$USE_SUDO
		[32;1mUSE_GVIM         [34;1m$USE_GVIM
		[30;1m                 [30;1m
		[33;1mSERVER DETAILS   [33;1mSetting (String Value)
		[32;1mVIM_SERVER       [34;1m$VIM_SERVER
		[32;1mGVIM_SERVER      [34;1m$GVIM_SERVER
		[32;1mVIM_SERVER_LIST  [34;1m${VIM_SERVER_LIST[@]}
		[32;1mVIM_S_T_FIND     [34;1m$VIM_SERVER_TO_FIND
		[32;1mVIM_S_T_USE      [34;1m$VIM_SERVER_TO_USE
		[32;1mVIM_LOOKUPLIST   [34;1m${VIM_SERVER_LOOKUPLIST[@]}
		
		[32;1m                 [34;1m
		[32;1mARGS (IN)        [34;1m$FUNCNAME $@
		[32;1mARGS (OUT)       [34;1m${VIMARGS[@]}
		[32;1m                 [34;1m
		[1;30mHRULE
		[0;31;1mvim will be started with these settings
EOF
	echo "${VIMARGS[@]}"
	if choice "Proceed?"; then
		command "${VIMARGS[@]}"
	fi

	return 1;
}

# }}}

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
# }}}

#### SORTED/UNCATEGORIZED

# {{{ FUNCTIONS A-Z

#### A
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
#### B
# {{{    bindings() [no args] : list keyboard bindings w/o obvious stuff + commonly used keyboard mod decodings
function bindings()
{
	__get_bindings

}
#}}}
#{{{     bmenuif(caption,item1,item2,...) - same as bmenu, but returns the variable in so you can use it in an if [[ ]] statement!
function bmenuif()
{
	# the trick is, we need to duplicate some handles, once this is done, it wont be undone, you have to use "bmenuif cleanup" to do that
	# map /dev/fd/3 to the 'normal' stdout
	case $1 in
		init)
			exec 7>&1;return 0;;
		cleanup)
			exec 7>/dev/null;return 0;;
	esac
	# really use it
	if bmenu "$@" 1>&7; then
		echo $?
	else
		echo 0
	fi
}
#}}}
#{{{     bmenu(caption,Item1,Item2,...) - Show a menu, The Items are like this: "Item|Description", the return value is the index (0=cancelled 255=esc or ctrl+c/other break)
function bmenu()
 {
	 # protect from dreaded empty arguments (making calls like: bmenu "" "" "" valid "" "" valid)
	 for each in "$@"; do [[ -z $each ]] && { CRIT "Failing on EMPTY values cannot be passed to command line: $# (args=$@)"; return 255; }; done

	 if [[ $# -le 1 ]]; then
		 WARN "You MUST specify at least ONE menu item for there to be a menu!"
		 INFO "A menu ${1+named \"$1\" }was requested, but there are no entries. Returning result as if CANCEL was pressed..."
		 sleep 2
		 return 0
	 else
		 declare caption="$1"; shift
		 declare -A items;
		 declare -A indicies;
		 declare -i n=1;
		 for i in "$@"; do
			 if [[ $i =~ ^[a-zA-Z_]+\|.+$ ]]; then
				 name=${i%%|*}
				 desc=${i##*|}
				 items[$name]="$desc"
				 indicies[$name]=$n
				 let n++
			else
				WARN "While parsing in position $n, found invalid item: $i. [Items must be in the form of NAME(A-z_)|DESCRIPTION(^|)]"
			fi
		done
		[[ ${#indicies[@]} -lt 1 ]] && { $FUNCNAME "$caption"; return $?; }	# delegate to the prerequisite checker it in a recursive call when there are no items
		# menu part
		local RESULTFILE RESULTFLAG RESULTITEM RESULTINDEX
		RESULTFILE=$(mktemp)
		eval dialog --menu \""$caption"\" 0 0 0 `for k in ${!items[@]}; do echo -ne "$k" "\"${items[$k]}\" "; done` 2> $RESULTFILE
		RESULTFLAG=$?
		case $RESULTFLAG in
			0)	# ok result
				RESULTITEM=$(cat "$RESULTFILE"); rm -f "$RESULTFILE"
				declare -gx BMENU_LAST_RESPONSE_ITEM=$RESULTITEM
				#please see note about not using $_ for repeats with DEBUG traps
				RESULTINDEX=$(( ${indicies[$RESULTITEM]} ))
				declare -gxi BMENU_LAST_RESPONSE_INDEX=$RESULTINDEX
				# if the user had wanted the target to be something (or somewhere) else, use it
				if [[ -v RESPONSE_TARGET ]]; then
					if [[ -w "$RESPONSE_TARGET" ]]; then											# use an (existing) file, add to it, allows for complex multiple question paths to collect data over a handful of	questions to a single file
						DEBM "Response target was set to a writable file"
						if [[ -s "$REPSONSE_TARGET" ]]; then
							DEBM "The response target file is not empty, inserting a newline for the new record entry..."
							echo -ne "\n" >> "$REPSONSE_TARGET" 									# newline if already has data
						fi
						echo -ne "$RESULTITEM::$RESULTINDEX" > "$RESPONSE_TARGET"
						if (($?)); then
							DEBM "The file $RESPONSE_TARGET was written to, the exit code ($?) was returned."
							DEBM "The operation succeeded"
						else
							WARN "The file $RESPONSE_TARGET attempted write, but failed with code ($?)"
						fi
					else
						eval "$REPSONSE_TARGET=$RESULTITEM"
						DEBM "Response target refers to a variable name"
					fi
					DEBM "Wrote: $RESULTITEM to $RESPONSE_TARGET"
				else
					# no response target
					DEBM "RESPONSE_TARGET is not set, and will not be assigned to in any way"
				fi
				return $RESULTINDEX
				;;

			1) # cancelled
				return 0;
				;;

			255) # user break or Escape pressed
				return 255;
				;;

		esac
	fi
 }
 #}}}
#### C
 #{{{     can_execute_x_progs() - returns true if x program can run (get the display and execute without an error) - the work is done by xprop
function can_execute_x_progs()
{
	# simply put, if xprop works, we know x is usable!
	xprop -root &>/dev/null
}
#}}}
# {{{    cat_minus_line() [line #-to-remove] [filename]
function cat_minus_line()
{
	local -i RLINE=${1-0}
	head  -n$(( RLINE -1 )) /home/gabriel/.bashrc
	tail -n+$(( RLINE +1 )) ~/.bashrc
}

# }}}
# {{{ _cur_pos() - return current pos
#!/bin/bash
function _cur_pos()
{
	local OLD_TERM_STATE OLDIFS CROW CCOL
	OLD_TERM_STATE=`stty -g`
	OLDIFS="$IFS"
	IFS=";"
	CROW=0
	CCOL=0

#	exec < /dev/tty
#	stty raw -echo min 0
#	if __isflag USE_TPUT_FOR_CURPOS; then
#		tput u7 > /dev/tty				 # user data slot #7 (used to store cursor-pos code, usually = ESC[6n)
#	else
#		printf '[6n' > /dev/tty                        # ANSI escape sequence -- stored in tc user7
#	fi
#	read -r CROW CCOL
#	stty "$OLD_TERM_STATE"


#	CROW=$(expr $(expr substr $CROW 3 99) - 1)        # Strip leading escape off
#	CCOL=$(expr ${CCOL%R} - 1)                        # Strip trailing 'R' off

	printf "%0d %0d" $CROW $CCOL
}
function _cur_row()
{
	slice_func _cur_pos
	local ret=`_cur_pos | sed 's/[0-9]*$//g'`
	echo $ret
	return $ret
}
function _cur_col
{
	slice_func _cur_pos
	local ret=`_cur_pos | sed 's/^[0-9]*//g'`
	echo $ret
	return $ret
}

# }}}
# {{{ choice(prompt) - ask a y/n question
function choice()
{
	if __isflag ALLOW_CHOICEFILE; then
		if [ -r "$CHOICEFILE" ]; then
			CHOICEPROMPT=`cat $CHOICEFILE`
		fi
	fi
	if [ -z "$CHOICEPROMPT" ] && [ "$1" ] && [ ! -r "$CHOICEFILE" ]; then
		CHOICEPROMPT="$*"
	fi
	if (tty -s); then

		# TTY -- TEXT CONSOLE -- NO GUI/NO NEED

		if [ ! -z "$CHOICEPROMPT" ]; then
			echo -n "$CHOICEPROMPT"
		elif [ -r "$CHOICEFILE" ]; then
			echo "${CHOICETITLE:-Proceed with this action?}"
			cat "$CHOICEFILE"
			echo "[Y=${CHOICEYESTXT:Yes} N=${CHOICENOTXT:No}]"
		else
			echo "[Y/N]?"
		fi
		unset REPLY
		while [ "${REPLY^^}" != "Y" ] && [ "${REPLY^^}" != "N" ]; do
			read -sn1
		done
		if [ "${REPLY^^}" == "Y" ]; then
			true
			return 0
			(exit 0)
		else
			false
			return 1
			(exit 1)
		fi
	else

		# NO TTY --- GUI --- USE ZENITY

		if [ ! -z "$CHOICEFILE" ]; then
			# use special kind, that supports text viewing..
			zenity --text-info --title="${CHOICETITLE:-Do you wish to perform this action?}" --ok-label="${CHOICEYESTXT:-Yes}" --cancel-label="${CHOICENOTXT:-No}" --file-selection "${CHOICEFILE}"
			return $?
		elif [ -z "$CHOICEPROMPT" ]; then
			CHOICEPROMPT="Do you wish to perform this action?"
		fi
		zenity --question --text="$CHOICEPROMPT"
		return $?
	fi
}
# }}}
# {{{    CRIT()	 "DISABLE_CRITICAL_ERROR_MESSAGES" - call echoer if this flag succeeds (=0)
function CRIT()	{	__echoer "DISABLE_CRITICAL_ERROR_MESSAGES" 	"$@";
}
# }}}
#### D
#{{{ dlg. functions (type dlg. and tab to see function names on cmd line)

	#  --buildlist    <text> <height> <width> <tag1> <item1> <status1>...
	#  --calendar     <text> <height> <width> <day> <month> <year>
	#  --checklist    <text> <height> <width> <list height> <tag1> <item1> <status1>...
	#  --dselect      <directory> <height> <width>
	#  --editbox      <file> <height> <width>
	#  --form         <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1>...
	#  --fselect      <filepath> <height> <width>
	#  --gauge        <text> <height> <width> [<percent>]
	#  --infobox      <text> <height> <width>
	#  --inputbox     <text> <height> <width> [<init>]
	#  --inputmenu    <text> <height> <width> <menu height> <tag1> <item1>...
	#  --menu         <text> <height> <width> <menu height> <tag1> <item1>...
	#  --mixedform    <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1> <itype>...
	#  --mixedgauge   <text> <height> <width> <percent> <tag1> <item1>...
	#  --msgbox       <text> <height> <width>
	#  --passwordbox  <text> <height> <width> [<init>]
	#  --passwordform <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1>...
	#  --pause        <text> <height> <width> <seconds>
	#  --prgbox       <text> <command> <height> <width>
	#  --programbox   <text> <height> <width>
	#  --progressbox  <text> <height> <width>
	#  --radiolist    <text> <height> <width> <list height> <tag1> <item1> <status1>...
	#  --rangebox     <text> <height> <width> <min-value> <max-value> <default-value>
	#  --tailbox      <file> <height> <width>
	#  --tailboxbg    <file> <height> <width>
	#  --textbox      <file> <height> <width>
	#  --timebox      <text> <height> <width> <hour> <minute> <second>
	#  --treeview     <text> <height> <width> <list-height> <tag1> <item1> <status1> <depth1>...
	#  --yesno        <text> <height> <width>

#}}}
# {{{    DEBM()  "ENABLE_DEBUG_MESSAGES" - call echoer if this flag succeeds (=0)
function DEBM()	{	__echoer "ENABLE_DEBUG_MESSAGES" 				"$@";
}
# }}}
# {{{    DETA()	 "ENABLE_DETAILED_MESSAGES" - call echoer if this flag succeeds (=0)
function DETA()	{	__echoer "ENABLE_DETAILED_MESSAGES" 			"$@";
}
# }}}
#### E
# {{{    eb() : edit bash configuration files directly
function eb()
{

	while ! bmenu "Edit Bash Configuration" "rc|Main Configuration File" "aliases|Aliases" "completion|Completion"	"dircolors.db|DirectoryColors" "git|GIT Integration" "hash|Hashtable" "helpers|Helpers" "history|History*" "logout|Logout" "settings|User Settings" "vars|User Variables" "xopen|X-Open All Files" "setup|Bash Setup Program	(Except This Menu)" ; do
		case $BMENU_LAST_RESPONSE_ITEM in
			rc) declare -ag EDITOR_FILE=( ~/.bashrc );;
		xopen) declare -ag EDITOR_FILE=( ~/.bashrc ~/.bash_!(*.swp) );;
   	setup) declare -ag EDITOR_FILE=( ~/.config/bashrc/data/setup-bashrc );;
			 *) declare -ag EDITOR_FILE=( ~/.bash_$BMENU_LAST_RESPONSE_ITEM );;
		esac
      for i in "${EDITOR_FILE[@]}"; do
			if [[ ! -r $i && -w $(dirname $i) ]]; then
				if dialog.yesno "File $i does not exist, create a new one?"; then
					maketemplate.sh
					HINT "You can edit the templates in the."
				else
					WARN "$i doesn't exist, but is still in the list, vim will create it for you if you save it"
				fi
			fi
		done

		vim "${EDITOR_FILE[@]}"

	done

	clear
	DETA "Configuration Complete"

}



# }}}
# {{{    __echoer() -
function __echoer()
{
	local __RET=$?
	local __FLG=$1; shift
	# this cache is used to store the color (or lack of color) so perl does not need to run each time
	[[ -v __ECHOER_COLORCACHE ]] || declare -gAx __ECHOER_COLORCACHE
	__isflag $__FLG && {
		if [[ -v __ECHOER_COLORCACHE[$__FLG] ]]; then
			echo -n "${__ECHOER_COLORCACHE[$__FLG]}"
		else
			local __FLG_COLOR_V=`perl -e '$_='$__FLG'; s/_?(DISABLE|IGNORE|ENABLE|INCLUDE|ENFORCE)D?_?//g; print "$_" . "_COLOR"'`
			[[ -v $__FLG_COLOR_V ]] && local __FLG_COLOR="${!__FLG_COLOR_V}"
	  		[[ -z "$__FLG_COLOR" ]] || { echo -n "${__FLG_COLOR}"; }
			__ECHOER_COLORCACHE[$__FLG]="$__FLG_COLOR"
		fi
		if [[ $1 == "--cat" ]]; then
			shift;
			echo -ne "$@"
		else
			[[ -v "IFS" ]] && OLDIFS=$IFS || OLDIFS=NONE
			IFS=''
			for j in "$@"; do
				echo $j
			done
	 		echo -ne "[0m"
			[[ $OLDIFS == NONE ]] && unset IFS || IFS=$OLDIFS
		fi
	}
 	return $__RET
}
# }}}
#### F
#{{{ fsdata_commit() : fast-start data commission



function fsdata_commit()
{
 slice_func fsdata_commit_stub
 fsdata_commit_stub "$@"
}

function fsdata_commit_stub()
{
 local FSDIR="${BASH_CONFIG_DIRS[faststart]}"
 mkdir --parents "$FSDIR" &> /dev/null

 if [[ ! -d "$FSDIR" ]]; then
	 CRIT "$FSDIR cannot be created/used"; (($?)) && return $? || return 1 ;
 fi

 DETA "Using directory $FSDIR for snapshots"
 HINT "Use fsdata_load to reload the last snapshot data manually"
 DEBM "$? Exporting Shell Options"
 { shopt -p; shopt -o -p; } > ${FSDIR}/fscache_.bash_1
 DEBM "$? Exporting Variables"
 declare -p > ${FSDIR}/fscache_.bash_2
 DEBM "$? Exporting Function Table"
 declare -pf | sed -r 's/^(\S+)\s+\(\)/function \1()/g'  > ${FSDIR}/fscache_.bash_3
 DEBM "$? Exporting Programmable Completion Assignments"
 complete > ${FSDIR}/fscache_.bash_4
 HASH
# 3 -> 1
# 2 -> 2
# 1 -> 3
# 4 -> 4


}

function fsdata_load()
{
 # expected to be slice_func'd when loading fast
 echo "in development (not available yet)"
}

#}}}
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
#### G
# {{{ _g_collect() - remove variables via garbage collection in UNLOADABLES
function _g_collect()
{
	local -i retv=0
	[[ -v UNLOADABLES ]] || return
   for unload_var in $UNLOADABLES; do
		if ! unset $unload_var; then
			echo "Warning: $FUNCNAME: cannot unset $unload_var"
			let retv++
		fi
	done
	return $retv
}



#}}}
#{{{     __get_bindings()
function __get_bindings()
{
	bind -p | grep '^(.*(\(not bound\)|self-insert|do-lowercase-version).*)$' -v | uniq --skip-fields=1 -u


}
# }}}
#### H
# {{{    HINT()  "DISABLE_HINTS" - call echoer if this flag succeeds (=0)
function HINT()	{	__echoer "DISABLE_HINTS" 							"$@";
}
# }}}
# {{{    histcount() - returns last history entry number
function histcount()
{
	local r=`history | tail -n-1 | grep -P '^\s*\d+' -o | tr -d ' '`
	return $r
}
# }}}
#### I
# {{{    INFO()	 "DISABLE_INFO_MESSAGES" - call echoer if this flag succeeds (=0)
function INFO()	{	__echoer "DISABLE_INFO_MESSAGES" 				"$@";
}
# }}}
# {{{    __isflag() -
function __isflag()
{
	uses __validflagname;


	# __isflag --- returns: 0=flag "true" result   1=flag "false" result   2=flag "badname" result
	# results:
	#    true - for normal flags, the flag was found, for inverted flags, not found
	#           example: FLAG_EXISTS was found, DISABLE_THIS_VALUE was not found
	#   false - same as above, only the opposite rules hold true
	#           example: VALUE_IS_OKAY was not found, FLAG_IS_OFF was fond
	#
	#  inverted values: flags starting with DISABLE, NO_, and NEVER_ are inverted
	#                   flags ending with _OFF, _EXCLUDED are inverted
	#                   flags ending with words that start with "UN" or "DIS" and end in "ED" are inverted also
	#                   exceptions are words like "UNIFIED" or "UNITED" which are ignored (kept uninverted)
	__validflagname "$1" || return 2;
	[[ -v BASH_FLAG_REGISTRY ]] || declare -agx BASHRC_FLAG_REGISTRY
	BASHRC_FLAG_REGISTRY+=( "$1" )
	# flags set by user at runtime (or by defaults) are saved at the end of session into the settings
	# any flag set and observed by __isflag will have this done to it, be mindful of what flags you set

	local __onval __offval
	# flags with these words invert the meaning of the flag
	[[ $1 =~ (^DISABLE|^IGNORE_|_OFF$|^NO_|^NEVER|_DISABLED$|_EXCLUDED$|_UN(^I[^AYEIOU])[A-Z]+ED$) ]] && __onval=1 || _onval=0
	let __offval=!__onval
	if [[ -v $1 ]]; then
		if [[ ${!1} -ne 0 ]]; then
			return $__onval;
		else
			return $__offval;
		fi
	else
		if	[[ -r ~/.config/bashrc/flags/$1 ]]; then
			eval $1=1
			return $__onval;
		else
			eval $1=0
			return $__offval;
		fi
	fi
}
# }}}
#{{{ isosched(task)
function isosched()
{
	# credit to quequotion@bbs.archlinux.org for this script-let
	if [[ $1 == -p ]]; then
		shift
		sudo schedtool -I -n -20 "$@"
		sudo ionice -c 2 -n 0 -p "$@"
	else
		sudo schedtool -I -n -20 -e ionice -c 2 -n 0 "$@"
	fi
}
#}}}
#{{{ idleprio(task)
function idleprio()
{
	# credit to quequotion@bbs.archlinux.org for this script-let
	if [[ $1 == -p ]]; then
		shift
		sudo schedtool -D -n 20 "$@"
		sudo ionice -c 3 -p "$@"
	else
		sudo schedtool -D -n 20 -e ionice -c 3 "$@"
	fi
}
#}}}
#### J K L
# {{{ _loadfunctioneditorfunctions() - load function editor functions
function _loadfunctioneditorfunctions()
{

	test -x ~/.config/bashrc/shells/function-editor/function-editor-functions.iash && source $_ || {
	echo "Required script: $_ is missing!"
	echo "You do not have the function editor functions installed, you will need to install them"

	echo -ne "${SERVICE_WEBSITE+Find them at: }$SERVICE_WEBSITE${SERVICE_WEBSITE+\n}"
	}

}


# }}}
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
#### M N O P Q
# {{{    makebashtags(alt_tags_location+filename) - recreate tagfile for all bash configuration scripts and place it in ~/tags (by default)
function makebashtags()
{
	DEBM "Checking for tagfile command line option"
	touch "$1"
	if [[ -w $1 ]]; then
		DEBM "Using $1 for tagfile.. dont forget to change it in .bashrc!!"
		HINT "the tags are put on the modeline!"
	else
		set -- ~/tags
		DEBM "Using default tagfile '~/.tags'"
	fi
	INFO "Recreating tag database in $1 ..."

	if [[ -d $GXBASE_ROOT ]] && dialog --yesno "Use gxbase locations as well?" 0 0; then
		declare -a EXTRA_LOCS=( $GXBASE_ROOT/gxbase $GXBASE_ROOT/core/* $GXBASE_ROOT/res/* )
	else
		declare -a EXTRA_LOCS=( "" )
	fi
	INFO "gxbase xtra locations added: ${#EXTRA_LOCS[@]}"

	if /usr/bin/ctags-exuberant -f "$BASH_CTAGS_FILE" --language-force=sh "${BASH_CTAGS_INC[@]}" "${EXTRA_LOCS[@]}"; then
		DEBM "ctags exit code=$?"
		INFO "ctags completed making file ($(stat --format="%s" $1))"
		HINT "add \"vim:tags=$1\" to your .bashrc and other scripts (or insert to existing line)"
		return 0
	else
		INFO "ctags failed to complete process ($?)"
		HINT "verify you have access to the bash system files located in /etc and /usr/share/bash-completion!"
		return 1
	fi
	CRIT "unreachable instruction reached. This usually means a serious bug (or more likely) hardware or power failure."
	WARN "waiting for <ENTER>"
	read
	return 254
}
#}}}
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
#{{{     makerandomlscolorsdb() - create a random .bash_dircolors.db file for LS_COLORS (used by dircolors, in turn by 'ls', 'dir', etc)
function makerandomlscolorsdb()
{
	unset USETRUE USE256 USE8 DOBG

	[[ $1 == TRUE ]]  && local USETRUE=1
	[[ $1 == 256 ]] && local USE256=1
	[[ $1 == 8 ]] && local USE8=1
	[[ $2 == BG ]] && local DOBG=1

	local BACKUPFILE=$(tempfile --suffix=dircolors.backupdb)
	echo "Backing up the old database in $BACKUPFILE..."
	# TODO: move into main globals for functions declarations
	declare -g DIRCOLORS_DBFILE="$HOME/.bash_dircolors.db"
	declare -g DIRCOLORS_SRC="$HOME/.bash_dircolors"
	# in case we do not yet have these files
   touch $DIRCOLORS_DBFILE
	touch $DIRCOLORS_SRC
	if mv $DIRCOLORS_DBFILE $BACKUPFILE; then
		echo "Creating database, please wait a minute..."
		dircolors -p |  sed 's/# .*//g;s/#//g' | tr -s '\n' > $DIRCOLORS_SRC
		[[ -r $DIRCOLORS_SRC ]] && echo "$DIRCOLORS_SRC verfied existing"
		if [[ $USETRUE ]]; then
			[[ $DOBG ]] &&	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s 38;2;%d;%d;%d;48;2;%d;%d;%d\n",$_,int(rand(255)),int(rand(255)),int(rand(255)),int(rand(255)),int(rand(255)),int(rand(255)) } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
			[[ $DOBG ]] ||	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s 38;2;%d;%d;%d\n",$_,int(rand(255)),int(rand(255)),int(rand(255)) } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
		elif [[ $USE8 ]]; then
			[[ $DOBG ]] ||	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s %d;%d;%d\n",$_,int(rand(2)),int(rand(8))+30,int(rand(8))+40 } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
			[[ $DOBG ]] &&	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s %d;%d\n",$_,int(rand(2)),int(rand(8))+30 } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
		else
			[[ $DOBG ]] &&	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s 38;5;%d;48;5;%d\n",$_,int(rand(255))+1,int(rand(255))+1 } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
			[[ $DOBG ]] ||	perl -e 'for (<>) { unless (/^TERM/ || /^\s*$/) { s/^(\S+)(.*)$/\1/g; chomp; printf "%s 38;5;%d\n",$_,int(rand(255))+1 } else { print } }' $DIRCOLORS_SRC > $DIRCOLORS_DBFILE
		fi
		rm $DIRCOLORS_SRC
		eval "$(dircolors -b $DIRCOLORS_DBFILE)"
		echo "Done."
	else
		echo "Could not create backup, aborted (check permissions to $(dirname $BACKUPFILE))!"
	fi

}
# {{{ makerandomlscolorsdb_[kind,{_bg}]() kind=true,256,8
function makerandomlscolorsdb_true() {	makerandomlscolorsdb TRUE; }
function makerandomlscolorsdb_256() { makerandomlscolorsdb 256; }
function makerandomlscolorsdb_8() { makerandomlscolorsdb 8; }
function makerandomlscolorsdb_true_bg() {	makerandomlscolorsdb TRUE BG; }
function makerandomlscolorsdb_256_bg() { makerandomlscolorsdb 256 BG; }
function makerandomlscolorsdb_8_bg() { makerandomlscolorsdb 8 BG; }
# }}}
#}}}
#### R
# {{{    rem_find_dir() [dirname] : removes a directory from FIND_IN_EXTRAS
function rem_find_dir()
{
	if [[ -d $1 ]]; then
		echo "removing find directory $1.."
	  if ENTRYNO=$(grep -Poison "FIND_IN_EXTRAS\+=:$1" ~/.bashrc | grep -Poiso "^\d+"); then
			echo "found entry #$ENTRYNO, removing"
			cat_minus_line $ENTRYNO ~/.bashrc > .bashrc.tmp
			mv ~/.bashrc /tmp/bashrc_rem_find_dir.tmp
			mv ~/.bashrc.tmp ~/.bashrc
		fi
	fi
}
# }}}
#### S T
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
# {{{    __setflag()              -
function __setflag()
{
	OPTIND=0
	while getopts "f:v:" opt; do
		case $opt in
			f)
				DETA "file: $OPTARG will be set"
				touch ${BASH_CONFIG_DIRS[flags]}/$OPTARG
				;;
			v)
				DETA "variable: $OPTARG will set in a variable for temporary purposes."
				;;
			*)
				CRIT "Error? opt=$opt OPTARG=$OPTARG OPTIND=$OPTIND"
				return 1
				;;
		esac
	done
	return 0;
}
# }}}
#{{{     setup_progvars( var_name, var_list_of_possible_programs, flagoverride, item_to_use_if_flag_override ) - select first available program found, uses alternate if it exists and flag was specified
function setup_progvars() # VAR_NAME, VAR_LIST_OF_POSSIBLE_PROGNAMES, FLAGOVERRIDE, ITEM_TO_USE_IF_FLAG_OVERRIDE
{
	# strongly typed parameters (assume shopt -os nounset)
	local -r ARG_COUNT=$#
	eval set \"\${1..4}\"
	local -r VAR_NAME="$1"
	local -r VAR_LIST_OF_POSSIBLE_PROGNAMES="$2"
	local -r FLAG_OVERRIDE="$3"
	local -r FLAG_OVERRIDE_TARGET=`which $4`

	case $ARG_COUNT in
		4) #flag-override mode
			if [[ -r ~/.config/bashrc/flags/$FLAG_OVERRIDE ]]; then
				if	[[ -x $FLAG_OVERRIDE_TARGET ]]; then
					echo "Overriding $VAR_NAME because of $FLAG_OVERRIDE - using $FLAG_OVERRIDE_TARGET"
					local -rn FINAL_TARGET=FLAG_OVERRIDE_TARGET
					break
				else
					echo "Warning: $FLAG_OVERRIDE specified, but $4 not found, failing back to default(s)"
				fi
			fi
			# fall through for normal processing
			;;&
		2) #normal mode
			[[ $VAR_LIST_OF_POSSIBLE_PROGNAMES ]] && local -r VAR_LIST_OF_POSSIBLE_PROGNAMES_EXPANDED=`for p in "$VAR_LIST_OF_POSSIBLE_PROGNAMES"; do which "$p"; done`
			if [[ ! -v VAR_LIST_OF_POSSIBLE_PROGNAMES_EXPANDED ]]; then
			{
				echo "Error: no programs found for $VAR_NAME in list ($VAR_LIST_OF_POSSIBLE_PROGNAMES)"
				local -r FINAL_TARGET=""
			}
			else
			{
				for t in "${VAR_LIST_OF_POSSIBLE_PROGNAMES_EXPANDED[@]}"; do
					if [[ -x "$t" ]]; then
						local FINAL_TARGET="$t"
						break
					fi
				done
			}
			fi
			;;
		*)
			echo "Error: invalid combination of arguments -- arg list: $*"
			local FINAL_TARGET=""
			;;
	esac

	if [[ ! -v FINAL_TARGET ]] || [[ $FINAL_TARGET == "" ]] || [[ ! -x $FINAL_TARGET ]]; then
		return 1
	else
		printf "$FINAL_TARGET"
		return 0
	fi

}
#}}}
#{{{     setvarif() [var_name] { [file] { [fallback] | { [if_found_value] { [not_found_value } } | [+FLAG] | [-FLAG] } - sets a variable under certain conditions (up to four arguments)
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
# {{{    shopts(filter (regular expression - perl syntax)) - show shell options and 'set' flags
function shopts()
{
	# called by 'show shopts'
	# moved from: /gxbase/bin/shopts script
	{ shopt -o; shopt; } | grep "${1-.*}" | awk '{ printf("%-030s\t^[[1m%-3s^[[0m\n",$1,$2); }' | sed -r 's/(^[\[)1(mon)/\132;1\2/g;s/(^[\[)1(moff)/\130;1\2/g' | column -c $[ $COLUMNS + 27 ]
}
#}}}
# {{{    show(item) - "smart" show the value of a variable, alias, function, binding, details of a package, manpage of a command, etc
function show()
{
	# TODO: move to BASH_SHOW_TARGETS array, and redesign an interface to add/remove the array elements
   if compgen -A $1 2>/dev/null; then
		return
	elif declare -fp $1 2>/dev/null; then
		return
	elif declare -p $1 2>/dev/null; then
		return
	elif alias $1 2>/dev/null; then
		return
	elif bind -p | grep $1 2>/dev/null; then
		return
	elif cat $1 2>/dev/null; then
		return
	elif ls -d $1 2>/dev/null; then
		return
	elif help $1 2>/dev/null; then
		return
	elif man -f $1; then
		man $1
		return
	elif [[ -r /usr/share/info/$1?([0-9])?(-.[0-9]).*info?(-[0-9]).gz ]]; then
		info $1
	elif apt-cache show "$1" 2> /dev/null; then
		return
	else
		if [[ -z $(apt-cache search $1 2>/dev/null) ]]; then
			bmenu "Cannot Locate Anything To Show" "Search|Find in Firefox" "Links|Find in Text Browser" "Nevermind|Don't Look"
			case $? in
				0|3|255)	INFO "Aborted [$?]";;
				1)	firefox -newtab  "http://www.google.com/search?q=${1// /+}";;
				2) links2 "http://www.google.com/search?q=${1// /+}";;
				*) CRIT "Error: unknown option returned = $?";;
			esac
		else
			apt-cache search $1 |less
		fi
	fi


}
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
		# regular which found one entry
		echo -ne "$WHICH"
	else
		# search the path too
		if WHICH=$(find_in_path "$*" 2> /dev/null); then
			echo -ne "$WHICH"
		else
			echo "$*"
		fi
	fi
}

#|||     switch_which_text(item) - returns switch_which item only if it points to a plain or unicode text file (not binary files)
function switch_which_text()
{
	local NAME=$(switch_which "$*")
	if [[ -f $NAME ]]; then
		if file $NAME | grep -q text; then
			echo -ne "$NAME"
		else
			echo -ne "$*"
		fi
	else
		echo -ne "$*"
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

# {{{    slice() [manpage[builtins]] [topic] [indentlevel[7]] [lines-after-topic[auto]]
function slice()
{
	local SPLICEMAN="$1"
}

function slice_stub()
{
	# note about SLICE_HOST: command must be full path to executable, and "SLICE_HOST" must be global
	#                        however if one condition isnt met, a local SLICE_HOST will be created
	# 								 this will NOT HARM your (their) globally or even other local copies of it!
	[[ -v SLICE_HOST ]] && [[ -x $SLICE_HOST ]] || local SLICE_HOST=/usr/bin/man
	local SLICE_OUTPUT=$(mktemp)
	local -i RETURN=0 # 0=no error  1=zero-length error  2=partial-length error  3=misc errors
	[[ $5 ]] && local SLICE_TAILCMD=( ${*: 5} ) || local SLICE_TAILCMD=( less -F )
	[[ $4 ]] && local SLICE_LINES="$4"  || unset SLICE_LINES
	[[ $3 ]] && local SLICE_INDENT="$3" || local SLICE_INDENT=7
	[[ $2 ]] && local SLICE_SEARCH="$2"
	[[ $1 ]] && local SLICE_TOPIC="$1"
	[[ $SLICE_LINES == auto ]] && unset SLICE_LINES
	[[ ! -x $SLICE_TAILCMD ]]  && local SLICE_TAILCMD=( command cat )

	DEBM "calling $FUNCNAME with args [$@], EV's are: $SLICE_TOPIC (topic) $SLICE_SEARCH (search) $SLICE_INDENT (slice_indent)"
	[[ $SLICE_TOPIC ]] && [[ $SLICE_SEARCH ]] && {
		if [[ -v SLICE_LINES ]] && "${SLICE_HOST[@]}" "$SLICE_TOPIC" | cat > $SLICE_OUTPUT; then
			if declare -n SLICE_START=`grep '^\s{'$SLICE_INDENT'}'$SLICE_SEARCH'.*$' "$SLICE_OUTPUT" -n | sed 's/:.*//g'`; then
				cat "$SLICE_OUTPUT" | tail -n+$SLICE_START | head -n+$SLICE_LINES | ${SLICE_TAILCMD[@]}
			else
				echo "Cannot get range, press to show: [A]ll Output  [N]o Output  [D]ump to log"
				while true; do
					case "$(read -sn1;echo ${REPLY^^})" in
						A)	INFO "showing $SLICE_OUTPUT ($(stat --format='%s' $SLICE_OUTPUT))"
							cat "$SLICE_OUTPUT"
							break
							;;
						N) WARN "not showing $SLICE_OUTPUT ($(stat --format='%s' $SLICE_OUTPUT))"
							rm "$SLICE_OUTPUT" -f
							break
							;;
						D)	echo -n "please enter an absolute or relative file or directory name [ENTER=auto]: "
							read; touch $REPLY &> /dev/null
							if [[ -w $REPLY ]]; then
								INFO "using $REPLY, it is a valid location";
								DUMPLOC=$REPLY
							elif [[ $REPLY =~ (stdout|stderr|stdin|^/dev/fd/) ]]; then
								WARN "pointless recursion detected - reshowing file instead (stdout/err)"
								DUMPLOC=/dev/stdout
							elif [[ -d $REPLY ]]; then
								INFO "directory provided, will provide automatic filename"
								DUMPLOC=$(mktemp -p $REPLY --suffix=${USER}s.dumped-output.txt)
							else
								if	[[ -r $REPLY || -s $REPLY || ! -w $REPLY || -n $REPLY ]]; then
									WARN "$REPLY is not writable, exists and/or is not zero length: will proceed with autonaming..."
								elif [[ -z $REPLY ]]; then
									INFO "Enter pressed without a filename, one will be created..."
								else
									WARN "Unknown reasons (or complex ones) we cant use $REPLY, using an automatic name..."
								fi
								DUMPLOC=$(mktemp --suffix=${USER}s.dumped-output.txt)
								INFO "dumping file contents to $DUMPLOC ..."
								if command touch "$DUMPLOC" && command cp "$SLICE_OUTPUT" "$DUMPLOC"; then
									INFO "file written ok from $SLICE_OUTPUT"
									DEBM "file $SLICE_OUTPUT copied from $DUMPLOC, with timestamp `date`"
									if rm $SLICE_OUTPUT; then
										DEBM "removed $SLICE_OUTPUT ok"
									else
										WARN "removal of $SLICE_OUTPUT was completed with error #$?, check the above message, if any."
									fi
								else
									CRIT "write operation (datestamp and data copy) to $DUMPLOC, with error #?, check any messages, and report them promptly!"
									HINT "if you want that $SLICE_OUTPUT file, you better do something with it before hitting enter"
									echo "failed! (press any key to continue)"
									read -sn1
								fi
							fi
							;;
						*)	CRIT "invalid choice, try again"
							HINT "some keys are CASE sensitive"
							local DO_OVER=1
							;;
					esac
					[[ -v DO_OVER ]] && unset DO_OVER || break
				done
			fi
		elif "${SLICE_HOST[@]}" "$SLICE_TOPIC" | perl -ne 'print if /^\s{'$SLICE_INDENT'}'$SLICE_SEARCH'/ .. /^(\s{'$SLICE_INDENT'}(?!'$SLICE_SEARCH'| )|[A-Z]+)/' | head -n-1 > $SLICE_OUTPUT; then
			local -i SLICE_SIZE=`stat $SLICE_OUTPUT --format='%s'`
			DETA "Slice Output is $SLICE_OUTPUT ($SLICE_SIZE byte$( [[ $SLICE_SIZE != 0 ]] && printf 's' ))."
			if (( SLICE_SIZE > 0 )); then
				cat "$SLICE_OUTPUT"
			else
				DEBM "Slice Output Zero-Length, Not Showing Anything"
				HINT "Try adjusting the search indent to a larger value, the slice function will then staircase-down to the first readable level."
				RETURN=1
			fi
		else
			if [[ -s $SLICE_OUTPUT ]]; then
				WARN "Error getting the slice, the partial output was returned:"
				cat "$SLICE_OUTPUT"
				RETURN=2
			else
				CRIT "Slice read error, and no text yeilded. Please check your regular expression and try again."
				RETURN=1
			fi
			rm "$SLICE_OUTPUT"
		fi
	} || {
		CRIT "Slice 'topic' and 'search' arguments/variables must be present! ($*) (TOPIC=${SLICE_TOPIC-empty} SEARCH=${SLICE_SEARCH-empty}";
	}
	# DO NOT USE "unset SLICE_HOST"!!! IT WILL WIPE OUT ANY GLOBAL INSTANCES!!! (but not other locally defined ones)
	unset SLICE_{OUTPUT,TOPIC,SEARCH,LINES_TO_OUTPUT,TAILCMD,INDENT};

}
# }}}
# {{{    specialdiradded() [name/desc]
function specialdiradded()
{
	local CRV=$? # retain $?
	 echo "* Special directory [1m${1}[0m added."
	 return $CRV # retain $?
}
# }}}
# {{{     stow_bashrc()
function stow_bashrc()
{
	cp ~/.bashrc ~/.bashrc_$(date +"%m%d%y_%H%M_%S")
}
#}}}
#### U
# {{{    undo_last_change() [nil] : restores last saved backup of .bashrc (stamps the current one)
function undo_last_change()
{
	cp ~/.bashrc ~/.bashrc_$(date +"%m%d%y_%H%M_%S")
	mv ~/.bashrc_previous ~/.bashrc -f
}

#}}}
#### V
# {{{    __validflagname()  -
function __validflagname()
{
	local FLAGNAME="$1"
	[[ $FLAGNAME =~ ^[A-Z_]+$ ]] && return 0 || return 1
}
# }}}
#### W
# {{{    WARN()	 "IGNORE_WARNINGS" - call echoer if this flag succeeds (=0)
function WARN()	{	__echoer "IGNORE_WARNINGS" 						"$@";
}
# }}}
# {{{    __wasflag() -
function __wasflag()
{
	# __wasflag([__setflag arguments])
	# returns: 0 = flag set as variable or file already
	#          1 = flag set, but was not set before
	#          2 = flag was not set before, and cannot be set this time for some reason (error shown by __setflag)
	local FLAGVALUE=${*: -1}
	if __isflag "$FLAGVALUE"; then
		# no need to call setflag, it's already there
		return 0;
	else
		# now passes all args to __setflag too (like -f or -v)
		if __setflag "$@"; then
			return 1;
		else
			return 2;
		fi
	fi

}
# }}}
#### X Y Z
# {{{ 	__xlatv() - fuzzy translate long variable names into their said values (ie, BSEM = BASH_SESSION_EXPERIMENTATION_MODES)
function __xlatv()
{

   local search_fuzzy=`echo $1 | sed 's/./\0.*_/g;s/_$//g'`
	local search_pfx=`echo "^${1}.*"'$'`
	local search_suf=`echo "^.*${1}"'$'`
	local search_sub=`echo "^.*${1}"'.*$'`
	local search_sfuzzy=`echo $1 | sed 's/./\0.*/g;s/_$//g'`
	# search_items - iterative array to walk all over
	# search_initiatives - each item is a flag applied to a single pass over search_items. Empty "" means no flags at all
	# and will be removed from command line if detected. This is reserved for future use (better grep out there that doesn't
	# care about empty params or has more search flags.) TODO: replace grep with awk or sed HERE.
	# TODO: make these variables not global when not testing (remove the -g flag)
	unset search_items search_initiatives result XLAT_VALUE XLAT_RESULT
	typeset -ga search_items=( $search_fuzzy $search_pfx $search_suf $search_sub $search_sfuzzy )
	typeset -ga search_initiatives=( "" "--ignore-case" ) # do normal search, then case-insensitive search
	typeset -ga result;
	typeset -ga variables=( `compgen -A variable` )


	for initiative in ${search_initiatives[@]}; do
		for item in "${search_items[@]}"; do
			[[ "$initiative" == "" ]] && unset initiative  # so grep doesn't interpret the empty value as pattern (!) happens	without this definition check
			for varname in "${variables[@]}"; do
				if [[ $varname =~ $item ]]; then
					result=$varname
				fi
				[[ -v $result ]] && break
			done
			[[ -v $result ]] && break
		done
		[[ -v $result ]] && break
	done
	if [[ ! -z $result ]] && [[ -v $result ]]; then
		declare -gx XLAT_RESULT=$result
		declare -gx XLAT_VALUE=${!result}
		case $2 in
			v*) # v* (variable,var,etc)
				echo -ne "$XLAT_VALUE";;
			n*) # n[ame]
				echo -ne "$XLAT_RESULT";;
			*) # other (normally we use 'a[rray]' here -- returns a value suitable to be used like this:
				# declare -a myarray=`__xlatv BLRIND`
				# declare myvalue=`__xlatv BLRIND v`
				# declare -n myvalue=`__xlatv BLRIND n`
				# varalias __xlatv BLRIND
			   # (note: varalias is tightly woven to __xlatv so it doesnt need extra error checking)
				echo -ne "( \"$XLAT_RESULT\" \"$XLAT_VALUE\" )";
		esac
	else
		if [[ ! -z "$3" ]]; then
			[[ "$2" =~ ^n.* ]] && echo -ne "DEFAULT" || echo -ne "$3"
		else
			CRIT "$FUNCNAME could not use [$1] to resolve any variable [n]ame or [v]alue ($2) and NO DEFAULT GIVEN (arg 3 empty!)"
		fi

	fi
}

# }}}

# }}}

# }}}
#{{{ COMPLETION
# }}}
#{{{ POSTINIT

# {{{ Shell Integration

#{{{ SPECIAL DIRECTORIES (used by 'cd' function)

#{{{ GITSH integration

#{{{ Save Aliases To This Point (dont define normal aliases after this) into ORIGINAL_ALIASES array
eval `declare -p BASH_ALIASES | sed 's/BASH_ALIASES/ORIGINAL_ALIASES/'`

#}}}
#{{{ Set Normal Prompts (needs 2 passes!) and keep original PWD in BASH_STARTUP_PWD for the post multi-pass
# my interactive stuff KEEP LAST
PS1_NORMAL=$PS1
PS2_NORMAL=$PS2
source ~/.config/bashrc/shells/git/git.bashrcshell
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
if [[ -d .git ]]; then
	CLEANUP_SAFE_LOCATION=$(mktemp -d)
	# put us in a guarenteed safe location (not a special dir) until startup completes
	cd "$CLEANUP_SAFE_LOCATION"
	CLEANUP_RETURN_TO_GIT=1
else
	CLEANUP_RETURN_TO_GIT=0
fi

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
function _termsg() {	echo "* Terminal [30;1m\"[0;1m$1[30;1m\"${2+ [30;1m([1;34m$2[30;1m)}[0m being used${3+ [30;1m([32m$3[30;1m)}[30;1m.[0m"; }

if [[ -z $DISPLAY ]]; then
	if ps $PPID | grep -q fbterm; then
		if [[ -f /usr/share/terminfo/f/fbterm ]]; then
			_termsg fbterm "termcap found OK" "frame-buffer terminal, color via tputs only emulated"
			export TERM=fbterm
		else
			_termsg fbterm "termcap not found" "Try `which sudo` `which dpkg-reconfigure` 'fbterm'."
		fi
	else
		if ps $PPID | grep -q screen; then
			_termsg screen "byobu/screen/etc"
			export TERM=screen
		elif ps $PPID | grep -q tmux; then
			_termsg tmux "byobu-tmux/tmux/etc"
			export TERM=tmux
		else
			export TERM=linux
			_termsg linux "256 color terminal" "recommended"
		fi
	fi
elif command ps $PPID | grep xterm -qos; then
	# really is xterm, so make the thing compatible (expected by some)
	export TERM=xterm
	_termsg $TERM "true xterm binary" "most compatible"
elif command ps $PPID | grep rxvt -qos; then
	# really is rxvt, force this for 256-color
	export TERM=rxvt-unicode-256color
	_termsg $TERM "true rxvt binary" "highly featured pixel font term"
else
	# we do not want to specify a default, let the terminal program's TERM variable shine through!
	# since it's termcap is probably 'special'
	# TODO: put a verification of some type here
	# DONE: added _partial_ info, now need verification -- a table of known terminals is needed for this (a uri would be best)
	_termsg $TERM "set by process" `ps c --no-headers $PPID | grep "\S*$" -o`
fi

# make terminal happy
setterm -i
stty sane


#}}}

# }}}
# {{{ Experimental (and potentially nonstandard) Last-Init Setup

if [[ $BASHRC_BACKUPS != OFF ]]; then
	export PATH=$PATH:/home/gabriel/.vim/bin
	# make a dated backup of this file in /var/archive/bashrc if possible (zipped)
	if [[ -w /var/archive/bashrc ]]; then
	RECENT_BASH_BACKUP_TARGET="/var/archive/bashrc/$(date +'%m%d%y_%H%M%S')_$USER"
	declare -n T=RECENT_BASH_BACKUP_TARGET
	if cp $BASH_SOURCE $RECENT_BASH_BACKUP_TARGET; then
		if ! gzip -9 $T; then
				echo "Warning: failed to compress(gzip) backup - $T ($?)"
			fi
		else
			echo "Warning: failed to copy(cp) backup - $T ($?)"
		fi
	else
		echo "Note: You are not keeping backups, please create a writable path in /var/archive/bashrc!"
		echo "      or turn off backups by setting BASHRC_BACKUPS to OFF."
	fi
else
	if ! __isflag BACKUP_WARNING_ONETIME; then

		echo "One-Time Warning: BASHRC_BACKUPS is now OFF, backups will not be made"
		echo "                  you must set it to ON or undefine it to allow backups,"
		echo "                  and create the archive in /var/archive/bashrc!"
		echo "(this message will NOT show again for this user unless the settings are wiped)"
	fi
fi



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

# change false to true if doing experimental stuff
if false; then
# {{{ Experimental Cleanup
# experimental future working with traps (put on back burner)
	# map all traps into _BASHRC_EXT_HOOKS in [F]UNCTIONS
	#or TRAPNAME in `compgen -A signal`; do
	#echo "Trapping $TRAPNAME..."
	#trap '__BASH_EXT_HOOK '$TRAPNAME' "${BASH_COMMAND[@]}" "$@"' $TRAPNAME;
	#one
	function __checkbashrc()
	{
		trap DEBUG
		trap SIGUSR1
		if [[ -v BASH_KEY_RESOURCING ]]; then return; fi
		if [[ ! -v BASH_KEY_SHA ]]; then
			BASH_KEY_ITEMS=( `for i in ~/.bash!(*.swp); [[ -d $i ]] || echo $i; done` )
			BASH_KEY_SHA=`eval shasum "${BASH_KEY_ITEMS[@]}" | shasum`
		else
			BASH_CHECK_SHA=`eval shasum "${BASH_KEY_ITEMS[@]}" | shasum`
			if [[ $BASH_CHECK_SHA != $BASH_KEY_SHA ]]; then
				BASH_KEY_RESOURCING=1
				__BASH_RELOAD_HOOK
				unset BASH_KEY_RESOURCING
				[[ $INGIT ]] || for aname in "${ORIGINAL_ALAISES[@]}"; do alias $aname="${ORIGINAL_ALIASES[$aname]}"; done
				[[ $INGIT ]] && for aname in "${GIT_ALIASES[@]}"; do alias $aname="${GIT_ALIASES[$aname]}"; done
				BASH_KEY_SHA=$BASH_CHECK_SHA
			fi
		fi
		trap __checkbashrc DEBUG
		trap __BASH_RELOAD_HOOK SIGUSR1
	}
	# create keys (first pass only)
	[[ -v BASH_KEY_ITEMS ]] || __checkbashrc
	trap __checkbashrc DEBUG
   trap __BASH_RELOAD_HOOK SIGUSR1

	# use SIGUSR1 this way:
	# in your vimrc, create an autocommand that executes this line:
	# (make sure you remove the #'s from the following lines!
	#augroup BASH_AUTORELOAD_CMDS
	#	au!
	#	au BufWritePost .bashrc !for procid in `pgrep bash`; do kill -USR1 $procid; done
	#augroup END

	#}}}
fi
#trap DEBUG
	# remove functions useless outside the .bashrc
	unset -f mkdirif
	unset -f _startup_trap
	unset -f _termsg
	# force some garbage collection, if needed
	_g_collect

	# set completions last (ensures use is correct)
	test -r /etc/bash_completion 								&& . $_ || {
	test -r /usr/share/bash-completion/bash_completion && . $_ || {
	echo "* Warning: No Completions Available!"             ;} ;}



	# reinstate command not found handler
	function command_not_found_handle() { __bashrc_ext_command_not_found_handler "$@"; }
	# enable setup program (soon) , this is done for xterm-style and tty-term style (the "old" f2)
	bind -x '"\eOQ": setup-bashrc'
	bind -x '"\e[[B": setup-bashrc'
	declare -A LONGNAMES=( [vop]="voperate" );

	# TODO: move into functions after secure tests
   function voperate()
	{
		# heart and soul operative function
		# does meta things, simply put:
		# syntax: vop
		while true; do
			VOP=$1; shift
			[[ -z $VOP ]] && break
			ACT=$1; shift
			[[ -v $ACT ]] && VACT=${!ACT} || VACT=0
   		[[ -z $ACT ]] && { CRIT "No Action Given with VOP: $VOP, failed to finish vop()"; return 2; }
			# process commands for vop
			case $VOP in
				DCOND)	# DCOND [varname,value] - check for condition variable, and delete the variable if it exists and equals nonzero
					[[ $VACT -ne 0 ]] && unset $ACT || return 1;;
				DDIR)	# DDIR [dir] delete a directory
					[[ -d $VACT ]] && { !rmdir $VACT || return 1; } || return 1;;
				SWD) #SWD [dir] set working directory
					[[ -d $VACT ]] && { !builtin cd $VACT || return 1; } || return 1;;
				*)
					CRIT "Unknown VOPerative: $VOP [arg was $ACT]" && return 1;;
			esac
		done
	};	vop() { voperate "$@"; };


	# very important
	set -ET
	voperate DCOND CLEANUP_RETURN_TO_GIT,1 DDIR CLEANUP_SAFE_LOCATION SWD BASH_STARTUP_PWD
   cd $BASH_STARTUP_PWD

	# KEEP LAST!
 	export BASH_IS_INITIALIZING=0

# }}}
#{{{ Revision Information
# -- has been moved to header
#}}}
# {{{ Modeline (keep at the end, needs no closing fold
# vim:ft=sh:smd:sm:shm=nflix:ts=3:sw=3:tw=120:noai:nowrap:tags=~/tags:ve=insert:fdo=search,jump,hor:fcl=all:cuc:cul:fdm=marker:fen:cc=100:fml=0:tw=9999:fdc=4:foldlevel=0

