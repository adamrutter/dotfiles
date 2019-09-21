#!/bin/bash

genre=$(playerctl metadata | grep genre)

# Podcast specific
if [[ "$genre" == *"Podcast"* ]]; then
	playerctl --player=rhythmbox position 10+

# Everything else
else
  playerctl --player=rhythmbox,spotify next
	
fi
