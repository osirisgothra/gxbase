
echo -e "$(abscol 33)gx.prompt namespace functions"

function gx.prompt.reload()
{
	source "$GXBASE_ROOT/vars.d/prompt.sh"

}; export -f gx.prompt.reload

# prompt fun, color fun
# use $(reset) for normal
function gxcolor()
{
	
	
	unset NOSET
	case $1 in 
		black) set 0 30;;
		red) set 0 31;;
		green) set 0 32;;
		brown) set 0 33;;
		blue) set 0 34;;
		magenta) set 0 35;;
		cyan) set 0 36;;
		gray) set 0 37;;
		none) set 0 0;;
		bright) set 1 1;;
		blink) set 8 8;;
		dkgray) set 1 30;;
		ltred) set 1 31;;
		ltgreen) set 1 32;;
		yellow) set 1 33;;
		ltblue) set 1 34;;
		ltmagenta) set 1 35;;
		ltcyan) set 1 36;;
		white) set 1 37;;
		brdef) set 0 1;;
		dim) set 1 2;;
		nodim) set 1 22;;
		nobrt) set 1 21;;
		*) NOSET=1 ;;
	esac
	
	if [[ -z $NOSET ]]; then
		builtin eval echo -ne '[${1}${2+;}${2}m'
	fi

	
	
}

function gxpcolor()
{
	if (! flag_exists NO_PROMPT_ENCASEMENT); then
		local ENCASEYES=$RANDOM
		local ENCASE=$ENCASEYES
	fi
	[[ $ENCASE == $ENCASEYES ]] && builtin echo -ne '\x01\x01'	 
gxcolor $@
	[[ $ENCASE == $ENCASEYES ]] && builtin echo -ne '\x02'
	return 0
}

function gx.prompt.edit()
{
	vim "$GXBASE_ROOT/vars.d/prompt.sh"
	gx.prompt.reload
}; export -f gx.prompt.edit 

function gx_getprompt()
{
	LASTRV=$?
	RUNCOUNT=`jobs -r | grep ".*" -c`
	STOPCOUNT=`jobs -s | grep ".*" -c`
	if [[ $RUNCOUNT > 0 ]]; then
		ARERUN=1
	fi
	if [[ $STOPCOUNT > 0 ]]; then
		ARESTOP=1
	fi
  RUNNINGPROC=`jobs -r | grep -Po "(?<=Running\s{17})[^\(]*" | grep -Po "[^/]*$"`
	RUNNINGPROC=`eval echo $RUNNINGPROC | tr "\n" " "`
	STOPPEDPROC=`jobs -s | grep -Po "(?<=Stopped\s{17})[^\(]*" | grep -Po "[^/]*$"`      
	STOPPEDPROC=`eval echo $STOPPEDPROC | tr "\n" " "`
	# all prompt text will be printed as if to standard output

		if [[ $LASTRV -eq 0 ]]; then
			unset ERRC
		else
			ERRC="$(gxpcolor ltred)$LASTRV$(gxpcolor none)"
		fi
		echo -ne "${ERRC}${ERRC+ }"
		if [[ $RUNCOUNT > 0 ]]; then
			
			echo -ne "$(gxpcolor dkgray)[$(gxpcolor ltgreen)${RUNNINGPROC}$(gxpcolor green)running$(gxpcolor dkgray)]$(gxpcolor none)"
			if [[ $STOPCOUNT > 0 ]]; then
				# put on separate lines because two on one line is too much
				echo ""
			fi
		fi
		if [[ $STOPCOUNT > 0 ]]; then

			echo -ne "$(gxpcolor dkgray)[$(gxpcolor ltred)${STOPPEDPROC}$(gxpcolor red)stopped$(gxpcolor dkgray)]$(gxpcolor none)"
#			echo -ne "$(gxpcolor green)[${STOPPEDPROC}stopped]$(gxpcolor none)"
		fi

		return $LASTRV

	}
