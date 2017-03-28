#!/bin/bash

bright_path="/sys/class/backlight/intel_backlight/brightness"
curr=$( cat $bright_path )


if [ "$1" == "up" ]; then
	curr=$((curr+5))
elif [ "$1" == "down" ]; then
	curr=$((curr-5))
else
	echo "fu"
	exit
fi

$( echo $curr >> $bright_path )
