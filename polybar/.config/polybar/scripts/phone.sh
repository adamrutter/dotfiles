#!/bin/bash

#
# Variables
#

# ID of the device; 'kdeconnect-cli -l' to find out
deviceId="b428cea5cb991bf0"

# Where the phone is mounted
mountPoint="/mnt/8B2X129GV/"

# The point at which the battery level should be considered low
lowLevel=30

# Colours
red=$(xrdb -query | grep -w color1 | awk '{print $2}')
# green=$(xrdb -query | grep -w color2 | awk '{print $2}')
# green=$(cat ~/.Xresources | grep -w 'accent' | grep -v '!' | tail -c 8)
green="#55b166"
inactive=$(cat ~/.Xresources | grep -w '#define base04' | tail -c 8)

# Call kdeconnect (Keeps following code much more DRY)
device="qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$deviceId" org.kde.kdeconnect.device"

#
# Functions
#

# Return an icon showing whether the phone is mounted or not
mountIcon() {
 if [[ $( ls $mountPoint* &> /dev/null; echo $? ) -eq 2 ]]; then
 	echo "%{T3}累%{T-}"
 else
 	echo "%{T3}ﺭ%{T-}"
 fi
}

# Return the battery level of the device
batteryLevel() {
	echo "$($device.battery.charge)"
}

# Return the battery level of the device
batteryPercentage() {
	if [[ "$($device.isReachable)" == 'true' ]]; then
		echo "$(batteryLevel)%"
	else
		echo "??%"
	fi
}

#
# Output
#

# Print the results as a string for Polybar
echo "%{F#a7adba}$(mountIcon)%{F-} $(batteryPercentage)"
