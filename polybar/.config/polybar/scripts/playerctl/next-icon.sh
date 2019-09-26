#!/bin/bash

status=$(playerctl --player=rhythmbox,spotify status 2> /dev/null)
if [[ "$status" == "Playing" ]] || [[ "$status" == "Paused" ]] || [ "$status" = "Stopped" ]; then

	# Podcast specific
	genre=$(playerctl metadata | grep genre)
	if [[ "$genre" == *"Podcast"* ]]; then
		echo ""

	# Everything else
	else
	  echo ""
	fi

else
	echo ""
fi
