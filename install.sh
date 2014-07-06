#!/bin/bash

pushd . &> /dev/null
cd $(dirname $BASH_SOURCE)
if [[ ! -r stubfile ]]; then
	echo "Error: stubfile not found, install possibly corrupt or in wrong dir, did you accidently copy install.sh?"
elif [[ ! -w /etc/bash_completion.d ]]; then
	echo "Error: you need to have root access to install on the system, use sudo install.sh"
	false
else
	echo "verifying installer..."
	if md5sum --quiet -c installer.md5; then
		echo "installing stubfile..."
		if ln -sf "$PWD/stubfile" /etc/bash_completion.d/zz9_gxbase_stub; then 
			echo "install complete, restart bash to be rid of gxbase's influence"
		else
			echo "install failed - check your permissions"
		fi
	else
		echo "install checksum failed, installation is not consistent and probably corrupt."
		echo "You must re-download gxbase, or, if you are sure the files are in-tact, please"
		echo "email the author <osirisgothra@hotmail.com>."
		echo "Automated install cannot continue and is halted."
	fi
fi

popd &> /dev/null

