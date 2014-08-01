# helpkey.sh
#
# shows key bindings currently in effect for bash (not just ones defined by gxbase)
#

function help_keys()
{
	local showhelp="
	Displays the keybindings currently in effect

	syntax: help_bindings [--long] [--help]

		--long		displays all the bindings for each function bound, not just the first key (not the default)
		--help		this text you are looking at

	See the manual documentation for further details"
	local showerr="The command line you entered is invalid, use --help or --long"
	echo "Current Key Bindings"
	if [ "$1" == "--long" ]; then
		bind -P | grep --invert-match "is not bound" | sed "s/can be found on/=/g" | sed "s/\"//g;s/\\\\C/CTRL/g;s/\\\\e/(Esc)/g;s/(Esc)(Esc)/(Esc)/g;s/\[C/LEFT/g" | grep --invert-match "self-insert" | sed "s/=\S*/[30;1m=[0m\0[1m/g"
	elif [ "$1" == "--help" ]; then
		echo $showhelp
	elif [ -z "$1" ]; then
		bind -P | grep --invert-match "is not bound" | sed "s/can be found on/=/g" | grep -Po "^[^\"]+\"[^\"]+\"(?=\,\ )" | sed "s/\"//g;s/\\\\C/CTRL/g;s/\\\\e/(Esc)/g;s/(Esc)(Esc)/(Esc)/g;s/\[C/LEFT/g" | grep --invert-match "self-insert" | column | sed "s/=\S*/[30;1m=[0m\0[1m/g"  
	else
		echo $showerr
	fi
}


if [ $TERM == linux ]; then
  bind '"\e[[A":"help_keys"'
else
	bind '"\eOP":"help_keys"'
fi

bind '"\eg":"cd $GXBASE_ROOT"'

echo -ne "$(abscol 33)Press [Esc] and then [F1] For A Quick Key Binding List"
