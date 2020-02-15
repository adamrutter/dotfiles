#!/bin/bash
DIRECTORY="/home/adam/pictures/screenshots"
DATE=$(date +"%Y-%m-%d-%H-%M-%S")
FILE=$DIRECTORY/$DATE.png
scrot "$FILE".png
notify-send "Screenshot" "$FILE"
canberra-gtk-play -i camera-shutter
