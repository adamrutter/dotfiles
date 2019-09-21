#!/bin/sh

while true;do

	status=$(playerctl --player=rhythmbox,spotify status 2> /dev/null)
	if [ "$status" = "Playing" ]; then
	    echo ""
	elif [ "$status" = "Paused" ] || [ "$status" = "Stopped" ]; then
	    echo ""
	else
	    echo ""
	fi

	sleep .1 &
	wait
done
