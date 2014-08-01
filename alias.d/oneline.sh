# oneline.sh
# process one-line aliases in the alias.d/oneline/ directory
if [ -s $GXBASE_ROOT/alias.d/oneline ]; then
	echo -ne "$(abscol 33)simple/single line file-based aliases" 
	unset IFS

	shopt -s nullglob
  for i in $GXBASE_ROOT/alias.d/oneline/*; do
		alias $(basename $i)="`cat $i`"
		# the RET variable is needed because echo sets the code back to zero
		# print in red if error code happened, uncomment next line to test this feature (ranges from 0-8)
		# (exit $[${RANDOM: 0:1}-1])
		RET=$?
		# per posix standards: error codes: 0-no error(no color) 1-noncritical(yellow) >=2-critical(red)
		case $RET in
			0) echo -ne "[0m";;
			1) echo -ne "[1;33m #$RET:";;
			*) echo -ne "[1;31m #$RET:";;
		esac
		echo -ne "$(basename $i)[0m "
	done


	# NEW: gx.oneline [funcname]
	# add/edit/delete function
	alias gx.ol='gx.oneline'
	function gx.oneline()
	{
		unset ERRMSG
		if [[ $2 ]]; then
			ERRMSG="too many arguments, just one, the new alias/existing alias name"
		elif [[ -z $1 ]]; then
			echo "needs a name"
			read -sn1
			RESPONSE=$(rdlg --inputbox "Enter new oneline alias name (single word)" 0 0)
			RESPONSE="${RESPONSE//[^-A-Za-z0-9]/}"
			if [[ $RESPONSE ]]; then
				NEWNAME=$RESPONSE
			else
				ERRMSG="cant use this name/canceled : $?"
			fi

		else
			NEWNAME=$1
			[[ -z $NEWNAME ]] && ERRMSG="Invalid command line: $*"
		fi

		if [[ -z $ERRMSG ]]; then

				if [[ -s $GXBASE_ROOT/alias.d/oneline/$NEWNAME ]]; then
					OLDTXT="$(cat $GXBASE_ROOT/alias.d/oneline/$NEWNAME)"
				else
					unset OLDTXT
				fi
				NEWLINE="$(rdlg --extra-button --extra-label "Delete Alias" --inputbox "Enter command line singular, no variables please" 0 0 $OLDTXT)"
				if [[ $? -eq 2 ]] && [[ -r $GXBASE_ROOT/alias.d/oneline/$NEWNAME ]]; then
					gx.deloneline "$NEWNAME"
				elif [[ $? -eq 0 ]] && [[ ! -z $NEWLINE ]]; then
					echo "$NEWLINE" > $GXBASE_ROOT/alias.d/oneline/$NEWNAME
				else
					echo "code returned: $?"
				fi
		else
				echo "$ERRMSG"
				echo "code $?"
				return 1
		fi
	}
	function gx.deloneline()
	{
		if [[ -r $GXBASE_ROOT/alias.d/oneline/$1 ]] && (dialog --yesnobox "Really delete $1 from oneline aliases permanantly?"); then
      rm -f $GXBASE_ROOT/alias.d/oneline/$1
			if [[ $? -eq 0 ]]; then
				echo "OK"
			else
				echo "cannot delete $1"
				return 1
			fi
			return 0			
		else
			echo "$1 does not exist as a onelined alias"
			return 1
		fi
		return 250
	}



	shopt -s nullglob
	echo ""
else
  echo -ne "$(abscol 33)no SL/FB aliases defined, skipping"	
fi

	
