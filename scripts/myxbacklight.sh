#!/bin/bash

bright_path="/sys/class/backlight/intel_backlight/"
curr=$( cat "$bright_path/brightness" )
maxb=$( cat "$bright_path/max_brightness" )

perc=$((100 * $curr / $maxb))

delta="$2"


if [ "$1" == "-get" ]; then
	echo "$perc"
	exit
elif [ "$1" == "-set" ]; then
	let "perc = $2"
elif [ "$1" == "-inc" ]; then
	let "perc += delta"
	# curr=$((curr+5))
elif [ "$1" == "-dec" ]; then
	let "perc -= delta"
	# curr=$((curr-5))
else
	echo "fu"
	exit
fi

perc=$(($perc>100?100:$perc))
perc=$(($perc<0?0:$perc))

let sett=maxb*perc/100


if [ "$3" == "-time" ]; then
	let bdelta=sett-curr
	dura="$4"
	tstep=10
	let nsteps=dura/tstep
	let tdelta=bdelta/nsteps
	echo "goal: $sett, duration: $dura, steps: $tstep, nsteps: $nsteps, tdelta: $tdelta, bdelta: $bdelta"
	tdelta=$(($tdelta==0?1:$tdelta))
	for ((i=0; i <= nsteps; i++)); do
		echo "set to: $curr"
		let curr+=tdelta

		$( echo $curr >> $bright_path/brightness )
		#sleep $tstep
		sleep 0.01
	done
else
	$( echo $sett >> $bright_path/brightness )
fi
