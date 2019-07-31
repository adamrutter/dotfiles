#!/bin/bash

while true; do
	player_status=$(playerctl status 2> /dev/null)

	if [ "$player_status" = "Playing" ]; then
	    echo "" 
	elif [ "$player_status" = "Paused" ]; then
	    echo ""
	else
	    echo ""
	fi
	sleep .1 &
	wait
done
