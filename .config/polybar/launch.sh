#!/bin/sh

killall -q polybar

#Wait for polybar to exit
while pgrep -x polybar > /dev/null; do
	sleep 1; done

MONITOR=DP-0 SYSTRAY=right polybar --reload mybar &
MONITOR=DVI-D-0 polybar --reload mybar2 &

echo "Polybar up"
