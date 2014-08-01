# permalas.sh
# process dynamic aliases and set up functions for them
if [ -s $GXBASE_ROOT/alias.d/pdma ]; then
	echo -ne "$(abscol 33)permalas (dynamic) aliases"
	unset IFS
  # TODO: please set perma.sh in func.d before continuing this feature.	 (i need a manager!)
	echo ""
else
	echo "no P/DA's found, skipping"
fi

	
