echo "This will uninstall gxbase, the quick and drity way, no undo!"
echo "PRESS ENTER TO DO IT, ALL GXBASE SETTINGS WILL BE REMOVED"
echo "[ENTER=UNINSTALL] [CTRL+C=ABORT] [CTRL+BREAK=ABORT]"
read
echo "Uninstalling...."
echo "checking for your old bashrc..."
if [[ -r ~/.bashrc.old ]]; then
	echo "restoring original..."
	mv ~/.bashrc /tmp/.bashrc.gxbase.trash
	echo "moving gxbased version to trash..."
	if (mv ~/.bashrc.old ~/.bashrc); then
		echo "original restored OK"
	else
		echo "original not restored OK"
		TRYAGAIN=Y
	fi
else
	TRYAGAIN=Y
fi
if [[ $TRYAGAIN ]]; then
	echo "can't access backup copy of original (~/.bashrc.old)"
	echo "removing gxbase content from present .bashrc..."
	if (cat ~/.bashrc | grep -P '^.*(?=gxbase).*$' --ignore-case --invert-match > ~/.bashrc.new) &&	(mv ~/.bashrc ~/.bashrc.old) && (mv ~/.bashrc.new ~/.bashrc); then
		echo "content removed, previous copy placed in ~/.bashrc.old"
		unset TRYAGAIN
	else
		echo "WARNING: cannot remove gxbase startup calls from your ~/.bashrc, you will need to do this manually!"
	fi
fi
echo "Removing settings..."
if (rm -fr ~/.config/gxbase) && [[ -z $TRYAGAIN ]]; then
	echo "[32;1mUninstall completed successfully, please log out and back in for effects to take place!"
else
	echo "[31;1mUninstall did not complete all the steps successfully, you will need to do these steps yourself:"
	if [[ -z $TRYAGAIN ]]; then
		echo "* Remove GXBASE References from your .bashrc script"
	fi
	echo "* Delete the ~/.config/gxbase directory"
	echo ""
fi
echo "[0m"
echo "PLEASE NOTE that the PREFIX DIRECTORY (where you unpacked gxbase) does not get deleted by the"
echo "un/installer because it could be in used by more than one user, ask your admin to remove it or"
echo "remove it manually if you do not need it again."
echo "To install gxbase again, just run the install.sh from within the gxbase extract directory!"
echo ""
echo "You can always get a brand new fresh copy anytime by typing:"
echo "                                         [1;32m ~~~~~~~  [0m         "
echo "         [1;34mgit clone git://gitorious.org/gxbase/gxbase.git[0m"
echo ""
echo "[1mThank you for trying GXBASE![0m"

