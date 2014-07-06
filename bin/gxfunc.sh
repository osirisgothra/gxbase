function ttgvim()
{
	if (tty -s) || [ -z "$DISPLAY" ]; then
		eval $SUDOON /usr/bin/vim $@
		retval=$?
	else
		eval $SUDOON /usr/bin/gvim $@
		retval=$?
	fi
	echo "recording exit value to /tmp/tgvim.exit"
	echo "$(date):$BASH_SOURCE:$retval" >> /tmp/tgvim.exit 2>&1
	return $retval
}
# tgvim 
# non-sudoized wrapper for ttgvim
function tgvim()
{
	unset SUDOON
	ttgvim $@
}
# sudotgvim
# sudoized wrapper for ttgvim
function sudotgvim()
{
	SUDOON="sudo -H"
	ttgvim $@
}

# not_contains [string] [char]
# returns true if $1 does not_contain $2[0] (one character only)
function not_contains()
{
 	local char=${2: 0:1}
	for ((i=0;i<${#1};i++)); do
		if [ ${1: i:1} == $char ]; then
			return 1
		fi
	done
	# never had a match, return false
	return 0
}
# not_contains_any [string] [string-of-chars]
# same as above, but $2 can be any length, each character is evaluated
function not_contains_any()
{
	for ((a=0;a<${#2};a++)); do
		if (not_contains $1 ${2: a:1}); then
			continue
    else
			return 0
		fi
	done
	# never matched anything, return false
	return 1
}



# makechoice
# a simple yes/no choice 
# case-insensitive, prompt optional
function makechoice()
{
	if [ -z "$CHOICEPROMPT" ] && [ "$1" ]; then
		CHOICEPROMPT="$*"
	fi
	if (tty -s); then
		if [ ! -z "$CHOICEPROMPT" ]; then
			echo -n "$CHOICEPROMPT"
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
		if [ -z "$CHOICEPROMPT" ]; then
			CHOICEPROMPT="Do you wish to perform this action?" 
		fi
		zenity --question --text="$CHOICEPROMPT"
		return $?
	fi
}

function getvol()
{
	 declare -i VOL
	 VOL=$(amixer sget Master | grep "(?<=  Mono: Playback )[0-9]*(?= \[)"  -Po)
	if [ "$1" == "echo" ]; then
		echo $VOL
		[ $VOL -gt 0 ] && return 0 || return 1
	elif [ "${1: 0:1}" == '$' ]; then
		eval $1=$VOL
	else
		return $VOL
	fi
}

function multimenu()
{
	echo -ne "Enter selection [1-${pos}]:"
	if [ -z "$1" ]; then
		echo "1. Yes"
		echo "2. No"
		(makechoice)
		return $?
	elif [ -z "$2" ]; then
		export CHOICEPROMPT="$1"
		(makechoice $CHOICEPROMPT)
		return $?
	fi
	declare -a item
	declare -i pos
	pos=1
	echo
	for i in $@; do 
		item[$pos]=$i		
		echo -ne "(${pos})\t $i\n"
		pos+=1
	done
	REPLY=0
	while [ $REPLY -lt 1 ] || [ $REPLY -gt $pos ] ; do
		read -sn1
		REPLY=$(($REPLY))
	done
	echo "${item[$REPLY]}"
  return $REPLY

}
