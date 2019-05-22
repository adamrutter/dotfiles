#!/bin/bash

#
# Variables
#

# ID of the device; 'kdeconnect-cli -l' to find out
deviceId="ccfe4b69f4dba72f"

# Where the phone is mounted
mountPoint="/mnt/sma520f/"

# The point at which the battery level should be considered low
lowLevel=30

# Colours
red=$(xrdb -query | grep -w color1 | awk '{print $2}')
#green=$(xrdb -query | grep -w color2 | awk '{print $2}')
green=$(cat ~/.Xresources | grep -w 'accent' | grep -v '!' | tail -c 8)

# Call kdeconnect (Keeps following code much more DRY)
device="qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$deviceId" org.kde.kdeconnect.device"

#
# Functions
#

# Return the battery level of the device
batteryLevel() {
	echo "$($device.battery.charge)"
}


# Return a color tag if the battery is below the defined level
batteryLow() {
	if [[ "$(batteryLevel)" -le "$lowLevel" ]]; then
		echo "%{F"$red"}"
	fi
}

# Return a color tag if the device is charging
batteryCharging() {
	if [[ "$($device.battery.isCharging)" == 'true' ]]; then
		echo "%{B- F-}%{F"$green"}"
	fi
}

# Return an icon showing whether the phone is mounted or not
icon() {
  if [[ $( ls $mountPoint* &> /dev/null; echo $? ) -eq 2 ]]; then
  	echo " "
  else
  	echo " "
  fi
}

#
# Output
#

# Print the results as a string for Polybar
if [[ "$($device.isReachable)" == 'true' ]]; then
  echo "$(icon) $(batteryLow)$(batteryCharging)$(batteryLevel)% %{B- F-}"
else
  echo "$(icon)"
fi
