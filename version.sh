#!/bin/bash
# version.sh
# displays version in a friendly manner
# this is a placeholder for the new gxb binary
# which will eventually be the centerpiece of the
# program (in fact 'the' program).
if [[ ! -r $GXBASE_ROOT/version.dat ]]; then
	printf "[version data missing]"
else
  printf "`cat $GXBASE_ROOT/version.dat`"
	# TODO: implement item extraction for gxb binary
fi
  
