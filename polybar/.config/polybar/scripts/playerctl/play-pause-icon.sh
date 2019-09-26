#!/bin/bash

status=$(playerctl --player=rhythmbox,spotify status 2> /dev/null)
if [[ "$status" == "Playing" ]]; then
    echo ""
elif [[ "$status" == "Paused" ]] || [[ "$status" == "Stopped" ]]; then
    echo ""
else
    echo ""
fi
