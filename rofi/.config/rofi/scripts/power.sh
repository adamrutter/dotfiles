#!/bin/bash

# Define options
options=(
  'Lock'
  'Reboot'
  'Reboot (to Windows)'
  'Poweroff'
)

if [[ -z "$@" ]]; then
  # Print options
  for i in "${options[@]}"; do
    echo $i
  done
else
  # Do options
  case "$1" in
    Lock)
      pkill rofi
      sleep 0.5
      /home/adam/bin/lock.sh
      ;;
    Reboot)
      systemctl reboot
      ;;
    "Reboot (to Windows)")
      sudo /home/adam/bin/reboot-to-windows.sh
      ;;
    Poweroff)
      systemctl poweroff
      ;;
    *)
      ;;
  esac
fi
