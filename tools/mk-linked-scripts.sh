#!/usr/bin/env bash

# --- options parsing begin --- see /usr/share/doc/util-linux/examples/getopt-parse.bash -- getopt(1) ---

CALLER="${BASH_SOURCE[1]}"
CALLERS="${BASH_SOURCE[@]: 1}"
PROGNAME="$(basename ${BASH_SOURCE})"
STRIPEXT=""

if OPTSTRING=`getopt -n "$PROGNAME" -s \? -- "$@"`; then
	eval set -- "$OPTSTRING"
	while [[ $1 != '--' ]]; do { OPT="$1"; shift 1; }
		case "$OPT" in
			-s)
				if [[ -w /dev/stdin && -r /dev/stdout ]]; then
					TMOUT=2
					echo "will be stripping extensions! [press any key ..2secs auto-advance.. ]"					
					read				
					unset TMOUT
				fi
				STRIPEXT='.*';;
			*)
				echo "error: $OPT - not implemented (yet), please notify the author if this is a release error!"
				;;
		esac
	done
	DOPARSE=1
else
	DOPARSE=0
fi

# --- end options parsing ---

# --- begin main processing script ---
(($DOPARSE)) && {

	PROC_COUNT=0
	for PROC_ITEM_SRC in "$@"; do
		PROC_ITEM_DEST="$(basename $PROC_ITEM_SRC)"
		PROC_ITEM_DEST="${PROC_ITEM_DEST%%$STRIPEXT}"
		ln -fvs "$PROC_ITEM_SRC" "$PROC_ITEM_DEST"
		(($?)) || { let PROC_COUNT++; }
	done
	[[ $PROC_COUNT == 1 ]] && { PROC_COUNT_ONE=s; }
	printf "\n%s item%s processed.\n",$PROC_COUNT,$PROC_COUNT_ONE

}
# --- main processing script ends! ---

