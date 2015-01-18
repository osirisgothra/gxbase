#!/bin/bash - 
#===============================================================================
#
#          FILE: cp.sh
# 
#         USAGE: ./cp.sh 
# 
#   DESCRIPTION: recursive copy with progress
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Gabriel Thomas Sharp (gts), osirisgothra@hotmail.com
#  ORGANIZATION: Paradisim Enterprises, LLC - http://paradisim.twilightparadox.com
#       CREATED: 01/15/2015 11:05
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

shopt -s globstar
shopt -s nullglob
shopt -s dotglob

function echo() 
{
	dialog 
}


echo "Reading directory structure..."
_DIRS=( `find -type d` )
echo "Creating a file list..."
_FILES=( `find -type f` )
echo "Structure Contents: ${#_DIRS[@]} dir(s) and ${#_FILES[@]} file(s)"

