#!/bin/bash
DIRECTORY="/home/adam/pictures/screenshots"
DATE=$(date +"%Y-%m-%d-%H-%M-%S")
FILE=$DIRECTORY/$DATE.png
scrot "$FILE"
notify-send "Screenshot" "$FILE" -u low
# canberra-gtk-play -i camera-shutter
