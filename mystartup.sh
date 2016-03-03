#!/bin/bash

# Keyboard
setxkbmap phisch-de
numlockx on

# Mouse
synclient VertEdgeScroll=0
synclient VertScrollDelta=-112
synclient HorizScrollDelta=-112
synclient HorizTwoFingerScroll=1
synclient PalmDetect=1

# Sound
pactl set-sink-mute 1 true

# Applications
#sudo gtk-redshift
