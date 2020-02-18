#!/bin/bash

# small power menu using rofi, i3, systemd and pm-utils
# (last 3 dependencies are adjustable below)
# tostiheld, 2016

Poweroff_command="systemctl poweroff"
Reboot_command="systemctl reboot"
Logout_command="exit"
Lock_command="/home/adam/bin/lock.sh"

# you can customise the rofi command all you want ...
rofi_command="rofi -i"

options=$'Lock\nReboot\nPoweroff'

# ... because the essential options (-dmenu and -p) are added here
eval \$"$(echo "$options" | $rofi_command -dmenu -p "")_command"
