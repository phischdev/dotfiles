#!/bin/bash

bright_path="/sys/class/backlight/intel_backlight/brightness"
curr=$( cat $bright_path )

delta=5

if [ ! -z "$2" ]; then
	delta=$2
fi

if [ "$1" == "up" ]; then
	let "curr += delta"
	# curr=$((curr+5))
elif [ "$1" == "down" ]; then
	let "curr -= delta"
	# curr=$((curr-5))
else
	echo "fu"
	exit
fi

$( echo $curr >> $bright_path )
