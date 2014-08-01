#!/bin/bash
#
# precheck.sh
#
# checks for required items
#
function check_for_pkg()
{
	if [[ $1 != $2 ]]; then
		echo -ne "checking for package $2 (has primary binary $1)..."
	else		
		echo -ne "checking for package $2..."
	fi
	dpkg-query -s $2 2>&1 | grep "^Status.*install.*installed" -q

	if [[ $? -gt 0 ]]; then
		echo "[31mNOT FOUND[0m"
		NOTINSTALL_COUNT+=1
		if [[ -z $NOTINSTALL_PKGS ]]; then
			NOTINSTALL_PKGS=$2
		else
			NOTINSTALL_PKGS+=" "$2
		fi
		return 1
	else
		echo "[32;1mOK[0m"
		return 0
	fi	
}
function check_for_pkg_s()
{
	check_for_pkg $1 $1
	return $?
}
declare -i NOTINSTALL_COUNT=0
# packages that are named different than their binaries
check_for_pkg calc apcalc
# typical packages 
check_for_pkg_s xtitle
check_for_pkg_s dialog
check_for_pkg_s zenity
check_for_pkg_s bash
check_for_pkg_s grep
check_for_pkg_s consolekit
check_for_pkg_s xmlstarlet
check_for_pkg_s whiptail
check_for_pkg_s x11-utils
check_for_pkg_s vim
# this list is subject to add/change/remove without warning
echo "Check completed."
unset -f check_for_pkg_s
unset -f check_for_pkg
if [[ $NOTINSTALL_COUNT -eq 0 ]]; then
	echo "All packages accounted for, continuing install..."
	return 0; exit 0
else
	echo "ERROR: the following $NOTINSTALL_COUNT package(s) are missing: $NOTINSTALL_PKGS"
	echo "Install now?"
	read -sn1
	if [[ $REPLY == y ]]; then
		sudo apt-get install $NOTINSTALL_PKGS
	else
		echo "Please install these packages before continuing the installation."
	fi
	echo "The installation needs to be re-run with the new packages in place."
	return 1; exit 1;
fi
