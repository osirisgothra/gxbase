# ~/.bash_logout: executed by bash(1) when login shell exits.
#[description=Bash Logout Script]

# when leaving the console clear the screen to increase privacy

if __isflag NO_BASHRC_FASTLOADING; then
	DEBM "fastload save begin..."
	fsdata_commit &> /dev/null
	DEBM "fastload save complete"
else
	DEBM "fastloading disabled, no cache save performed"
fi	
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
