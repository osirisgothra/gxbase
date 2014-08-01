# ges
# a script editor fe for gxb
#
echo -ne "$(abscol 33)script editor for gxbase"
function ges_editor()
{
	/usr/bin/vim $@
	return $?
}

function ges()
{
	unset notspecial;
	unset nogo;

  function	showhelp()
	{
		echo "
		gxbase editor front-end for shell scripts

		syntax: ges [a|b|p|u|d|i|f|v|name] [partial[filename]] 
			              DIRECTORY MARK         FILE NAME
		options:
				DIRECTORY MARK	
				A single-character mark that designates which 
				directory to work with. If it is not specified, it will default
				to the GXBASE_ROOT (which is now $GXBASE_ROOT). You should use
				one of the following:

					a) alias.d			b) bind.d				p) preq.d
					u) startup.d		d) shutdown.d		i) builtins.d
					f) func.d				v) vars.d				

				Anything else will be searched for, if it is found it will be used
				as the arguments (along with any other names) to the editor defined
				by ges_editor function. This function may be overriden by the user.

	  	  FILE NAME
				If the users specifies a DIRECTORY MARK, then the FILE NAME is either
				a partial or complete filename in the subdirectory. For example, to
				edit a script called \"foobar.sh\" assuming no other simmilar script
				exists in alias.d, you would type \"ges a foo\" and the remaining chara-
				cters would be filled in for you. 
				
				LIMITS

				1) Multiple files are not supported unless
				the directory mark is ommitted since it probably is not useful. 
				2) If an invalid file is given, a list is presented.
				3) If you specify NO file name, the editor will be started with the 
				   the directory's name which in vi and vim, will show a directory listing mode.
					 In other editors, like gedit, it will result in error display. Some might not
					 even start at all. Be careful with this feature.
					 
		Please see README and LICENSE distributed with gxbase for more information"

		unset -f showhelp
		return 127
	}

	case "$1" in
		*" "*) echo "commands can't have spaces"; local nogo=1 ;;
	a) local subdir=alias.d;;
  b) local subdir=bind.d;;
  p) local subdir=preq.d;;
  u) local subdir=startup.d;;
	d) local subdir=shutdown.d;;
	i) local subdir=builtins.d;;
	f) local subdir=func.d;;
	v) local subdir=vars.d;;
--help) showhelp; return $?;;
--list) shift; find "$GXBASE_ROOT/$*" | column; return $?;;
	*) local subdir=$1;
		 local notspecial=1;;
	esac

	FORHELPMORE="Bad Command or Filename, Use ges --help for command line information."

	if [[ $nogo ]]; then
		echo $FORHELPMORE
		return 127
	else
    if [[ $notspecial ]]; then
			if [ -z "$1" ]; then		
				pushd .
				cd /
				ges_editor ./$GXBASE_ROOT/
				popd
			elif [ -r "$1" ]; then
				echo "$1 does exist, sending command line to editor..."
				ges_editor "$@"
			else
				# not zero, not valid
				echo $FORHELPMORE
				return 126
			fi				
		else
			if [[ $2 ]]; then
				echo "Handling special: $2"
        if [ -r "./$GXBASE_ROOT/$subdir/$2*" ]; then
					ges_editor "./$GXBASE_ROOT/$subdir/$2*"
				else
					shopt -s checkwinsize
					COLUMNSMIN=$[ $COLUMNS - 1 ]
					if [ $COLUMNSMIN < 1 ]; then
						COLUMNSMIN=79
					fi
					echo "That file does not exist, or it is too partial or ambigious... here is a list of possible values:"
					for ((i=0;i<$COLUMNSMIN;i++)); do echo -ne "-"; done
					echo ""
					find "$GXBASE_ROOT/" | sed "s/\.\///g" | column
					echo ""
					for ((i=0;i<$COLUMNSMIN;i++)); do echo -ne "-"; done
					echo "Type [ges $1 [name or partial name]] to edit these files."
					echo "Type [ges $1 by itself to start in directory mode."
				fi			
			else
				pushd .
				cd /
				ges_editor ./$GXBASE_ROOT/$subdir
				popd
			fi
		fi
	fi
	return $?		
}

function ges_cleanup()
{
	echo "[ges.sh] cleaning up ges editor functions..."
	unset -f ges_editor ges ges_cleanup	
}                  

# shutdown of gxbase sends this message, this is the cleanup message
# used esp. when gxbase to be unloaded but not the shell, second one
# is for the shell exiting

trap ges_cleanup SIGUSR2 SIGTERM SIGKILL SIGHUP

