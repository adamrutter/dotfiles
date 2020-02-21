#!/bin/bash
# if [[ $1 != *"notify-send"* && $1 != *"dunstify"* ]]; then
# if [[ $2 != "Volume notification" && $2 != "Screenshot" ]]; then
if [[ $5 != *"LOW"* ]]; then
  canberra-gtk-play -i message
fi
