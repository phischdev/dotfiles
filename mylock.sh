#!/bin/sh -e
scrot /tmp/screen_locked.png
convert /tmp/screen_locked.png -scale 10% -scale 1000% /tmp/screen_locked.png
i3lock -i /tmp/screen_locked.png &
sleep 1;
rm /tmp/screen_locked.png
#sleep 60; pgrep i3lock && systemctl suspend
