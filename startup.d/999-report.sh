# 999-report.sh
#
# purpose: 1) display end-of-startup session-unique report(s) if any
#          2) takes a census of the local environment block reporting size in bytes
#          3) reports the REDLINE if size is beyond the redline amount (default redline >= 640k)
#             the typical environment block size is between 100k-300k depending on system
# usual location: /usr/local/gxbase/startup.d/999-report.sh
# called indirectly by /usr/local/gxbase/startup.sh 
# via an automated call using gxecute in /usr/local/gxbase/gxbase (the core script)  
#
# This is a level 2 script (1 indirect callers/1 direct callers)
#
# Author:
#    Gabriel Thomas Sharp <osirisgothra@hotmail.com>  
# 
# Copyright (C)2013 Paradisim Enterprises, LLC 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This file was created 
# For more support, visit our homepage: http://paradisim.tk
# Report any bugs to <bugs@paradisim.tk> or visit our FAQ on our website.
#
export GXBASE_SESSION_PREFIX=`echo $(tty) | tr -d "/"`
declare -i GXBASE_ENV_CENSUS_REDLINE=0
export GXBASE_ENV_CENSUS_REDLINE=655360
abscol 0
unset IFS
# this is done to keep the variable used local, as to not use any more environment space (report should NEVER use any environment space except for the census variable)
( 
	for i in /tmp/$GXBASE_SESSION_PREFIX-report.tmp; do if [[ -r $i ]]; then command cat "$i"; command rm -f "$i"; fi; done
)
abscol 0
set > /tmp/envset 2>&1
if [ -r /tmp/envset ]; then
	# the 7 bytes added in is the estimated size of the GXBASE_ENV_CENSUS variable itself, usually 6 digits + 1 null = 7 bytes
  declare -i GXBASE_ENV_CENSUS=$[ $(stat --format='%s' /tmp/envset) + 7 ]
	echo -e "$[ $GXBASE_ENV_CENSUS / 1024 ]k resident environment size (1k = 1024 bytes)" 
	if [[ $GXBASE_ENV_CENSUS -gt $GXBASE_ENV_CENSUS_REDLINE ]]; then
		echo "WARNING: Environment size is past redline, either raise the redline or reduce gxbase scripts/items that are no longer needed. A typical GXBASE environment size for a single-user account is usually in the range of 100k to 300k (1k = 1024 bytes)."
	fi
	export GXBASE_ENV_CENSUS
fi
rm /tmp/envset > /dev/null 2>&1                                                                         
