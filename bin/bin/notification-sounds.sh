#!/bin/bash
# if [[ $1 != *"notify-send"* && $1 != *"dunstify"* ]]; then
if [[ $2 != "Volume notification" && $2 != "Screenshot" ]]; then
# notify-send "$1" "$2\n$3\n$4\n$5"
  canberra-gtk-play -i message
fi
