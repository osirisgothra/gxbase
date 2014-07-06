#!/bin/bash

dialog

function return()
{
	dialog clear
	echo "return in a function: $*";
	unset -f return;
  exit $*;
}

return 12;


echo "this should not be executed: $? star=$*"
