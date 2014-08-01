#!/bin/false
#depends=light.sh
#depedants=
#provides=gx.light.inject 12 45 
#provides=gx.light.eject 48 77
#provides=gx.light.count 79 82
#provides=gx.light.list 84 98

echo -e "$(abscol 33)light e/injection utility"

function gx.light.act()
{
	ACT=$1
	shift
	TGT=$1
	shift
	$ACT "$GXBASE_ROOT/func.d/light/$TGT" "$@"
}
function gx.light.edit()
{
	if [[ -z $1 ]]; then echo "insufficient arguments, one is required"; return 1; fi
	echo "Creating backup in /tmp..."

	cp "$GXBASE_ROOT/func.d/light/$1" "/tmp/$1"
	echo "Starting editor for modification..."
	vim "/tmp/$1"
	echo "Checking text signatures..."
	diff "/tmp/$1" "$GXBASE_ROOT/func.d/light/$1" > /dev/null 2>&1
  declare -i RET=$?
	# RET for intermediate test point on exit value
	# echo $RET #uncomment to do test echo
	#
	if [[ $RET -eq 1 ]]; then
		echo -ne "Physical difference after editing, reinjecting..."
		mv -f "$GXBASE_ROOT/func.d/light/$1" "/tmp/${1}.{$RANDOM}.old" > /dev/null 2>&1		
		mv -f /tmp/$1 $GXBASE_ROOT/func.d/light/$1 > /dev/null 2>&1
	  gx.light.injects "$@"
		echo "done"
		echo "Note that the overwritten function was backed up temporarily in "/tmp/${1}.*.old" but will be deleted when system restarts."
	else
		echo "No (Physical) difference after editing, no injection needed."
	fi
}
function gx.light.src()
{
	gx.light.act less $*
}

function gx.light.injects()
{
	TGT=$GXBASE_ROOT/func.d/light/$1
	NAM=$1
	TMPF=/tmp/$RANDOM-$USER-inject.tmp
	echo "function $NAM()" > $TMPF
	echo "{" >> $TMPF
	cat "$TGT" >> $TMPF
	echo "}" >> $TMPF
	source $TMPF
	rm -f $TMPF
}


# light.inject <name> <command>
function gx.light.inject()
{
	local NEP=Y
	if [[ $1 ]]; then
		NAME=$1
		shift
	else
		unset REPLY
		echo 'Name and function not defined, interactive mode enabled!'
		while [[ "$REPLY" == "" ]]; do
			echo -ne 'Name of new lightfunction:'
			read
			echo ""
		done
		NAME=$REPLY
	fi
	if [[ -z $1 ]]; then
		declare -l nf=/tmp/file_null_$RANDOM-lightinject.tmp
		for cmd in rm touch; do $cmd -f $nf; done
		RESULT=`dialog --backtitle "Function Body Editor" --title "Create Your GxBase LightFunction(tm)" $nf $[ $LINES - 5 ] $[ $COLUMNS - 5 ]`
		#echo "Function body missing, please type your function, press ENTER on a blank line to end:"
		#while (true); do
		#	unset REPLY		
  	#	read
		#	if [[ "$REPLY" != "" ]]; then
		#		REPLIES+=;$REPLY
		#3	else
		#3		break
		#	fi
		#done
		if [[ $? -eq 0 ]]; then
			set -- "$REPLY"
		else
      echo "Aborting..."	
			eval $GXBASE_SAFEXIT
			#case $- in *i*)	return;; *) exit;; 
			#esac		
		fi
		
	fi

		
	if [[ $NAME ]]; then
		if [[ $* ]]; then
			unset OVERWRITE
			unset NEP
			if [[ -e $GXBASE_ROOT/func.d/light/$NAME ]]; then
				if (! choice "overwrite $NAME? "); then
					OVERWRITE=N
				fi
			fi			
			if [[ -z $OVERWRITE ]]; then
				echo "Creating $NAME"
				echo $* > $GXBASE_ROOT/func.d/light/$NAME
				if [[ $? == 0 ]]; then
					echo "Creation OK"
					echo "Injecting into environment..."
					echo "function $NAME () " > /tmp/lightfunction
					echo "{" >> /tmp/lightfunction
					cat "$GXBASE_ROOT/func.d/light/$NAME" >> /tmp/lightfunction
					echo "}" >> /tmp/lightfunction
					source /tmp/lightfunction
					if [[ $? -eq 0 ]]; then
						echo "Injection OK"
					else
						echo "Injection Error($?) - try restarting gxbase and/or check your function."
						echo "Tip: to quickly remove light functions you can use gx.light.eject <fname>."
					fi
					command rm -f /tmp/lightfunction
					if (choice "Enter a description for this command?"); then
						unset REPLY
						while [[ -z $REPLY ]]; do
							echo -ne "Enter a description\n\t[press ENTER when done]: "
							read
						done
						echo "Creating description file..."
					else
						echo "Creating empty readme file [you can edit it later]..."
					fi
					READMEFILE="$GXBASE_ROOT/func.d/light/.README.$NAME"
					if [ -r $READMEFILE ]; then
						if (choice "Description File Exists, Overwrite It?"); then
							unset SKIPWRITE
						else
							SKIPWRITE=1
						fi
					else
						unset SKIPWRITE
					fi
					if [[ -z $SKIPWRITE ]]; then
						echo -ne "Writing file..."
						echo "abstract=$REPLY" > $READMEFILE
					  [[ $? -eq 0 ]] && echo "OK" || echo "Error($?), Check Permissions."
					else
						echo "Writing Aborted"
					fi
					echo "Finished Creating LightFunction."
				else
					echo "Creation Error($?)"
				fi
			else
				echo "Cancelled"
			fi
		fi
	fi
	if [[ $NEP ]]; then
		echo "Not enough parameters. Syntax is: $FUNC_NAME <function-name> <function-body>"
		echo "Keep lightweight functions simple. If you need more complexity, try permafunc."
	else
		gx.log "Function Executed Signifigant Vars $* $NAME, $FUNC_NAME" 
	fi
}	

# light.eject <name>
function gx.light.eject()
{
	if [[ -e $GXBASE_ROOT/func.d/light/$* ]]; then
		echo "-------------- function $*() ------------start--"
		cat $GXBASE_ROOT/func.d/light/$* 
		echo "-------------------------------------------end--"
		echo ""
		if (choice "Remote this light function?"); then
			echo "removing (moving as trash in /tmp/gxbase-trash-$* if possible..."
			if (mv $GXBASE_ROOT/func.d/light/$* /tmp/gxbase-trash-$*); then
				echo "light function successfully recycled"
			else
				echo "can't recycle, file is being deleted..."
				if  (rm -f $GXBASE_ROOT/func.d/light/$* /tmp/gxbase-trash-$*); then 
					echo "light function removed okay."
				else
					echo "can't delete this light function, check your file permissions"'!'
				fi
			fi
      echo "removing function from environment table..."
			unset -f $1
		  [[ $? -eq 0 ]] && echo "function removed from environment." || echo "function not removable, try restarting gxbase."
			
		else
			echo "cancelled removal process, no harm done."
		fi
	else
		if [[ $* ]]; then
			echo "Light function not found: $*"
		else
			echo "No light function specified, you must specify a name."
		fi
	fi
}

function gx.light.count()
{
	ls -C $GXBASE_ROOT/func.d/light/[^.]* | grep ".*" --word-regexp --count 
}

function gx.light.list()
{
	echo ""
	echo "Light Functions"
	echo ""
	unset IFS
  for nn in `command ls -C "$GXBASE_ROOT/func.d/light/"[^.]*`; do
		ll=$(basename $nn)
		echo -ne "\t$ll$(abscol 33)"
		READMEF="$GXBASE_ROOT/func.d/light/.README.$ll"
		if [[ -r $READMEF ]]; then
			cat $GXBASE_ROOT/func.d/light/.README.$ll | grep -Po "(?<=abstract=).*$" | cat
		else
			READMEF=$nn
			stat $READMEF --format="$(cat $READMEF | grep -Po "^\S*" --max-count=1 --word-regexp), owner=%U, %s byte(s)"
		fi
	done
	echo ""
	echo "Use a subshell () to call light functions, or in a parameterized variable \$()."
	echo "There are currently $(gx.light.count) light functions available."
	echo ""
}

