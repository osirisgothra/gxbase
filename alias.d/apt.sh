
#
# apt.sh
#   
#   APT Related aliases
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

unset APTSH
APTSH="sudo "

if [[ $UID -eq 0 ]] && [[ ! -z $APTSH ]]; then

	cat $BASH_SOURCE | sed 's/sudo //g' > /tmp/apt.sh
	for i in source rm; do $i /tmp/apt.sh; done	

else

	# note: scripts executed (not sourced/gxecuted) don't inherit aliases, aliases are executed at function declaration, not function execution, be careful!
	echo -ne "$(abscol 33)APT/DPKG namespace (apt.|dpkg.xxx commands, "

	# since namespace-style name and command differ, the list cannot be automated
	alias apt.help='man apt-get; true'
	alias apt.install='sudo apt-get install'
	alias apt.search='sudo apt-cache search'
	alias apt.get='sudo apt-get download'
	alias apt.purge='sudo apt-get purge'
	alias apt.clean='sudo apt-get autoclean; sudo apt-get autoremove; true'
	alias apt.src='sudo apt-get source'
	alias apt.update='sudo apt-get update; true'
	alias apt.upgrade='sudo apt-get update; sudo apt-get upgrade; true'
	alias apt.show='sudo apt-cache show'
	alias apt.akey='sudo apt-key add'
	alias apt.rkey='sudo apt-key del'
	alias apt.export='sudo apt-key export'
	alias apt.xall='sudo apt-key exportall'
	alias apt.ukey='sudo apt-key update; sudo apt-key net-update; true'
	alias apt.arepo='sudo apt-add-repository'
	alias apt.auto='sudo apt-mark auto'
	alias apt.manual='sudo apt-mark manual'
	alias apt.hold='sudo apt-mark hold'
	alias apt.uhold='sudo apt-mark uhold'
	alias apt.autoshow='sudo apt-mark showauto'
	alias apt.manshow='sudo apt-mark showmanual'
	alias apt.holds='sudo apt-mark showhold'
	alias apt.shell='aptsh; true'

	alias dpkg.arc='sudo dpkg-architecture'
	alias dpkg.bfl='sudo dpkg-buildflags'
	alias dpkg.bpk='sudo dpkg-buildpackage'
	alias dpkg.cbd='sudo dpkg-checkbuilddeps'
	alias dpkg.daf='sudo dpkg-distaddfile'
	alias dpkg.deb='sudo dpkg-deb'
	alias dpkg.div='sudo dpkg-divert'
	alias dpkg.gcg='sudo dpkg-genchanges'
	alias dpkg.gnc='sudo dpkg-gencontrol'
	alias dpkg.gsy='sudo dpkg-gensymbols'
	alias dpkg.mrg='sudo dpkg-mergechangelogs'
	alias dpkg.msh='sudo dpkg-maintscript-helper'
	alias dpkg.nam='sudo dpkg-name'
	alias dpkg.pcl='sudo dpkg-parsechangelog'
	alias dpkg.qry='sudo dpkg-query'
	alias dpkg.rcn='sudo dpkg-reconifugre'
	alias dpkg.scs='sudo dpkg-scansources'
	alias dpkg.sld='sudo dpkg-shlibdeps'
	alias dpkg.sor='sudo dpkg-statoverride'
	alias dpkg.spk='sudo dpkg-scanpackages'
	alias dpkg.spl='sudo dpkg-split'
	alias dpkg.src='sudo dpkg-source'
	alias dpkg.tgr='sudo dpkg-trigger'
	alias dpkg.vnd='sudo dpkg-vendor'


	if (assert_flag NO_APT_SUDO_COMMANDS) || [[ $UID -eq 0 ]];  then
		echo -ne "SUDO off) "
	else
		echo -ne "+ sudoized dpkg/apt) "
		# instead of doing it in a list, automate the alias creation since we know the names ahead
		# of time	
		for i in $(ls -C /usr/bin/apt-* /usr/bin/apt /usr/bin/dpkg-* /usr/bin/dpkg --color=never); do 
			alias ${i/\/usr\/bin\//}='sudo '$i	
		done 

	fi





fi












































