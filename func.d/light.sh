#!/bin/false
#depends=
#dependants=gx.prompt.sh

echo -ne "$(abscol 33)lightweight functions: "

# get into this script's directory so we can relatively check without using long paths
pushd . 2>/dev/null 1>&2
cd $(dirname $BASH_SOURCE)
# begin in-dir processing
unset IFS
if [[ -d "./light" ]]; then
	declare -i total=0
	declare -i funcsz=0
	for ii in $(command ls -C light/[^.]* | sed "s/light\///g"); do  	
  	#echo -ne "$ii"
		echo "function $ii()" > /tmp/light-func.tmp
		echo "{" >> /tmp/light-func.tmp
		cat ./light/$ii >> /tmp/light-func.tmp
		echo 'return $?' >> /tmp/light-func.tmp
		echo "}" >> /tmp/light-func.tmp
		# instead of the buggier: eval "function $ii() { $(cat ./light/$ii); }"
		# which can be unpredictable, the alternative above is solid as a rock
		source /tmp/light-func.tmp
		funcsz=`stat /tmp/light-func.tmp --format="%s"`
		total+=$funcsz
		command rm -f /tmp/light-func.tmp > /dev/null 2>&1
		#echo -ne "(${funcsz}) "
	done
	totalkb=$(calc "$total / 1024")
	echo "(`echo ${totalkb} | grep -Po "[0-9]*\.[0-9]{2}"`kb total)"
else
	echo "(empty or missing directory $PWD/light)"
fi

# end in-dir processing
popd 2>/dev/null 1>&2
