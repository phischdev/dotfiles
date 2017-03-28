#!/bin/bash

pid=0
arg2=""

#echo "$1, $2, $3"

if [ "$1" == "-id" ]; then
	echo "specified id"
	pid=$2
	arg2=$3
elif [ "$1" == "-m" ]; then
	echo "find id via mouse"
	pid=$(xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //')	
	arg2=$2
else
	echo "--help"
	exit
fi

signal=0

if [ "$arg2" == "-s" ]; then
	signal="19"
elif [ "$arg2" == "-c" ]; then
	signal="18"
else
	echo "$arg2"
	echo "stop or continue? (-s -c)"
	exit
fi

#echo "kill -$signal $pid"
$(kill -$signal $pid)



