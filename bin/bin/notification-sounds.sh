#!/bin/bash
# Only play a sound if the notification doesn't come from notify-send
# For notify-send, play a sound in the script where it is called
if [[ $1 != *"notify-send"* && $1 != *"dunstify"* ]]; then
  canberra-gtk-play -i message
fi
