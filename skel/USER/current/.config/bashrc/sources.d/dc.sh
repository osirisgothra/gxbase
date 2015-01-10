#!/bin/bash -c 'echo "Must run interactive!"'

#
#  file: dc.sh
#  name: dialog and related completion and helpers
#  date: dec 22, 2014
#  time: 9:42pm
#    by: Gabriel Sharp <osirisgothra@hotmail.com> http://paradisim.twilightparadox.com
#



function _testcomplete()
{
	export COMP_LARGS=( "$@" )
	printf '[s[1;1H'
cat <<-EOF
		Completion Statistics
		-----------------------------------
		COMP_CWORD      $COMP_CWORD
		COMP_KEY        $COMP_KEY
		COMP_LINE       $COMP_LINE
		COMP_POINT      $COMP_POINT
		COMP_TYPE       $COMP_TYPE
		COMP_WORDBREAKS ${COMP_WORDBREAKS[@]}
		COMP_WORDS      ${COMP_WORDS[@]}
		COMP_LARGS*     ${COMP_LARGS[@]}
		COMPREPLY       ${COMPREPLY[@]}
		-----------------------------------
		* this is \$1, \$2, etc
EOF
	printf '[u'

}
complete -F _testcomplete test

function _dialog()
{
	# if not declared already
	[[ ! -v MAPPINGS ]] && declare -Agx MAPPINGS
	# add local mappings to the list
	# gdialog is a wrapper for zenity that follows 'dialog' (cdialog) command structure, borrow 'dialog's help
	# gdialog offers ZERO command line help as it does not want you to write compatibility code (for some unknown reason)
	# gdialog expects everyone to write zenity-specific code and forget the most widely accepted and used ui tool in linux
	# zenity: sorry, that is not happining here! (this gives back what has been stolen)
	MAPPINGS[gdialog]=dialog

	local CMDNAME=$1
	local FOUNDFLAG=0
	local CURIDX=0
	# mapping applied
	for item in "${!MAPPINGS[@]}"; do
		if [[ $item == $CMDNAME ]]; then
			CMDNAME="${MAPPINGS[$item]}"
		fi
	done
	# do not check the current word, let _longopt complete it if no others are found
	for item in "${COMP_WORDS[@]}"; do
		CURIDX+=1
		[[ $CURIDX == $COMP_CWORD ]] && break # do NOT test on current word!
		#echo -ne "Checking item [$item]..."
		if [[ "$item" =~ ^--[a-z]+ ]]; then
			FOUNDFLAG=1
			local FOUNDITEM="$item"
			#	echo "pass"
		else
			#	echo "fail"
			if [[ "$item" =~ ^-- ]]; then
				FOUNDFLAGPREFIX=1
			else
				FOUNDFLAGPREFIX=0
			fi			
		fi
	done
	if [[ $FOUNDFLAG == 1 ]]; then
		FOUNDITEM2=${FOUNDITEM//-/}
		if $CMDNAME --help-$FOUNDITEM2 &> /dev/null; then
			echo
			$CMDNAME --help-$FOUNDITEM2
			echo -ne "$COMP_LINE"
		elif $CMDNAME --help | grep '^\s*'$FOUNDITEM &> /dev/null; then
			#echo "FOUND IT!!!"
			# echo -ne "$COMP_LINE"
			echo
			$CMDNAME --help | grep --color=never -P '^\s*'$FOUNDITEM 2>&1
			echo -ne "$COMP_LINE"
		else
			# cant find it!
			# echo "DIDNT FIND IT: $FOUNDITEM $FOUNDFLAG"
			_longopt "$@"
			return $?
		fi
	else
		#echo "NO FLAGS FOUND: $FOUNDFLAG $FOUNDITEM"
		if [[ $FOUNDFLAGPREFIX == 1 ]]; then
			_longopt "$@"
		else
			_minimal "$@"
		fi
		return $?
	fi
	return 0
}
complete -F _dialog dialog
complete -F _dialog whiptail
complete -F _dialog zenity
complete -F _dialog kdialog
complete -F _dialog gdialog
complete -F _dialog cdialog
complete -F _dialog xdialog

function dialog()
{
	if [[ $1 == "--help" ]]; then
		cat <<EOF
cdialog (ComeOn Dialog!) version 1.2-20130928
Copyright 2000-2012,2013 Thomas E. Dickey
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

* Display dialog boxes from shell scripts *

Usage: dialog <options> { --and-widget <options> }
where options are "common" options, followed by "box" options

Special options:
  --create-rc "file"		Dump a sample configuration file to "file"

Common options:
  --ascii-lines                 Rather than draw graphics lines around boxes, draw ASCII "+" and "-" in the same place.
  --aspect <ratio>              Number of characters wide to every line. Default value is 9 (9 chars wide for every line).
  --backtitle <backtitle>       Specifies a backtitle string to be displayed on the backdrop, at the top of the screen.
  --beep                        (obsolete) Beep when the separate process of tailboxbg widget repaints the screen.
  --beep-after                  (obsolete) Beep after a user completed a widget by pressing one of the buttons.
  --begin <y> <x>               Specify the position of the upper left corner of a dialog box on the screen.
  --cancel-label <str>          Override the label for the "Cancel" buttons.
  --clear                       Clears the widget screen keeping the screen_color background. Use with the "and widget" flag.
  --colors                      Translate \Z0-\Z7 to colors, \Zr to reset, \Zb for bold or \Zn to normal (default) color.
  --column-separator <str>      Tell dialog to split data for radio/checkboxes and menus on the occurrences of the given string
  --cr-wrap                     Interpret embedded newlines in the dialog text as a newline on the screen.
  --date-format <str>           specify the format of the date printed for the calendar widget if  the  host provides strftime.
  --default-button <str>        Set the button for the user to press Enter to proceed through a dialog with minimum interaction.
  --default-item <str>          Set the default item in a checklist, form or menu box.
  --defaultno                   Make the default value of the yes/no box a No.
  --exit-label <str>            Override the label used for "EXIT" buttons.
  --extra-button                Show an extra button, between "OK" and "Cancel" buttons.
  --extra-label <str>           Override the label used for "Extra" buttons. For inputmenu defaults to "Rename".
  --help-button                 Shows a help button after OK and Cancel. If used returns output token HELP. See item-help flag. 
  --help-label <str>            Overrides the label used for help buttons.
  --help-status                 If the help-button is selected, writes the checklist, radiolist or form information after the item-help "HELP" information.
  --help-tags                   Modify  the  messages written on exit for [help-button] by making them always just the item's tag.
  --hfile <str>                 Display the given file using a textbox when the user presses F1.
  --hline <str>                 Display the given string centered at the bottom of the widget.
  --ignore                      Ignore options that dialog does not recognize.
  --input-fd <fd>               Read keyboard input from the given file descriptor. The default is /dev/stdin.
  --insecure                    Makes the password widget friendlier but less secure, by echoing asterisks for each character.
  --item-help                   Interpret the tags data for check, radio and menu boxes adding a column which is displayed in the bottom line.
  --keep-tite                   Does not keep initializing the same xterm alt screen on consecutive runs, if available.
  --keep-window			Do not erase this widget when it becomes inactive (finishes).
  --last-key                    Report last keyboard key entered via the 'curses keycode'.
  --max-input <n>               Limit input strings to a given size (in <n>, naturally).
  --no-cancel                   Suppress the cancel button in dialogs that use it.
  --no-collapse                 disable converting tabs to spaces and reduction of multiple spaces to single spaces, etc.
  --no-cr-wrap                  
  --no-items
  --no-kill
  --no-label <str>
  --no-lines
  --no-mouse
  --no-nl-expand
  --no-ok
  --no-shadow
  --no-tags
  --nook
  --ok-label <str>
  --output-fd <fd>
  --output-separator <str>
  --print-maxsize
  --print-size
  --print-version
  --quoted
  --scrollbar
  --separate-output
  --separate-widget <str>
  --shadow
  --single-quoted
  --size-err
  --sleep <secs>
  --stderr
  --stdout
  --tab-correct
  --tab-len <n>
  --time-format <str>
  --timeout <secs>
  --title <title>
  --trace <file>
  --trim
  --version
  --visit-items
  --yes-label <str>
Box options:
  --buildlist    <text> <height> <width> <tag1> <item1> <status1>...
  --calendar     <text> <height> <width> <day> <month> <year>
  --checklist    <text> <height> <width> <list height> <tag1> <item1> <status1>...
  --dselect      <directory> <height> <width>
  --editbox      <file> <height> <width>
  --form         <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1>...
  --fselect      <filepath> <height> <width>
  --gauge        <text> <height> <width> [<percent>]
  --infobox      <text> <height> <width>
  --inputbox     <text> <height> <width> [<init>]
  --inputmenu    <text> <height> <width> <menu height> <tag1> <item1>...
  --menu         <text> <height> <width> <menu height> <tag1> <item1>...
  --mixedform    <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1> <itype>...
  --mixedgauge   <text> <height> <width> <percent> <tag1> <item1>...
  --msgbox       <text> <height> <width>
  --passwordbox  <text> <height> <width> [<init>]
  --passwordform <text> <height> <width> <form height> <label1> <l_y1> <l_x1> <item1> <i_y1> <i_x1> <flen1> <ilen1>...
  --pause        <text> <height> <width> <seconds>
  --prgbox       <text> <command> <height> <width>
  --programbox   <text> <height> <width>
  --progressbox  <text> <height> <width>
  --radiolist    <text> <height> <width> <list height> <tag1> <item1> <status1>...
  --rangebox     <text> <height> <width> <min-value> <max-value> <default-value>
  --tailbox      <file> <height> <width>
  --tailboxbg    <file> <height> <width>
  --textbox      <file> <height> <width>
  --timebox      <text> <height> <width> <hour> <minute> <second>
  --treeview     <text> <height> <width> <list-height> <tag1> <item1> <status1> <depth1>...
  --yesno        <text> <height> <width>

Auto-size with height and width = 0. Maximize with height and width = -1.
Global-auto-size if also menu_height/list_height = 0.
EOF

	else
 		command dialog  --backtitle 'General Extended Bourne Again Shell Extensions' "$@"
	fi
}


export DIALOGRC="${BASH_CONFIG_DIRS[root]}/sources.d/dialogrc"
