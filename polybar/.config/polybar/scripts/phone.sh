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

# Return a battery icon
batteryIcon() {
	# if [[ "$($device.battery.isCharging)" == 'true' ]]; then
	# 	echo ""
	if [[ "$($device.battery.charge)" -le 10 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 20 ]] && [[ "$($device.battery.charge)" -gt 10 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 30 ]] && [[ "$($device.battery.charge)" -gt 20 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 40 ]] && [[ "$($device.battery.charge)" -gt 30 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 50 ]] && [[ "$($device.battery.charge)" -gt 40 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 60 ]] && [[ "$($device.battery.charge)" -gt 50 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 70 ]] && [[ "$($device.battery.charge)" -gt 60 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 80 ]] && [[ "$($device.battery.charge)" -gt 70 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 90 ]] && [[ "$($device.battery.charge)" -gt 80 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	elif [[ "$($device.battery.charge)" -le 100 ]] && [[ "$($device.battery.charge)" -gt 90 ]]; then
		if [[ "$($device.battery.isCharging)" == 'true' ]]; then
			echo ""
		else
			echo ""
		fi
	fi
}

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
mountedIcon() {
  if [[ $( ls $mountPoint* &> /dev/null; echo $? ) -eq 2 ]]; then
  	echo "%{F"$inactive"}%{B- F-}"
  else
  	echo ""
  fi
}

# Return battery information
batteryInfo() {
	if [[ "$($device.isReachable)" == 'true' ]]; then
		echo " $(batteryLow)$(batteryCharging)$(batteryIcon) $(batteryLevel)% "
	else
		echo " %{F"$inactive"}%{B- F-} "
	fi
}

# Return mount info
mountInfo() {
	echo " $(mountedIcon) "
}

#
# Output
#

# Print the results as a string for Polybar
echo "$(mountInfo)$(batteryInfo)"
