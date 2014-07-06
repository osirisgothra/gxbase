#!/bin/bash

pushd . &> /dev/null
cd $(dirname $BASH_SOURCE)
if [[ ! -r stubfile ]]; then
	echo "Error: stubfile not found, install possibly corrupt or in wrong dir, did you accidently copy uninstall.sh?"
#note: the -L had to be used in the case of dead links
elif [[ ! -L /etc/bash_completion.d/zz9_gxbase_stub ]] && [[ ! -e /etc/bash_completion.d/zz9_gxbase_stub ]]; then
	echo "It looks like gxbase is not installed, you cannot uninstall it."
elif [[ ! -w /etc/bash_completion.d ]]; then
	echo "Error: you need to have root access to install on the system, use sudo uninstall.sh"
	false
else
	echo "verifying installer..."
	if md5sum --quiet -c installer.md5; then
		echo "removing stubfile..."
		if rm -f /etc/bash_completion.d/zz9_gxbase_stub; then 
			echo "uninstall complete, restart bash to be rid of gxbase's influence"
		else
			echo "uninstall failed - check your permissions"
		fi
	else
		echo "installer checksum failed, installation is not consistent and probably corrupt."
		echo "You must re-download gxbase, or, if you are sure the files are in-tact, please"
		echo "email the author <osirisgothra@hotmail.com>."
		echo "Automated uninstall cannot continue and is halted."
	fi
fi

popd &> /dev/null

