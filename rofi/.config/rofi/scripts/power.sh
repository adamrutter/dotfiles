#!/bin/bash

# Define options
options=(
  'Lock'
  'Reboot'
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
    Poweroff)
      systemctl poweroff
      ;;
    *)
      ;;
  esac
fi
