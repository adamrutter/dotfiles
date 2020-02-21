#!/bin/bash
declare -A modes
modes[Files]="~/.config/rofi/scripts/files.sh"
modes[Power]="~/.config/rofi/scripts/power.sh"
keys=(${!modes[@]})

# Loop through array and concatenate the key:value pairs together
for (( i=0; $i < ${#keys[@]}; i++ )); do
  modes+="${keys[$i]}:${modes[${keys[$i]}]}"
  if [[ $i -lt ${#keys[@]}-1 ]]; then
    modes+=","
  fi
done

rofi -show drun -display-drun "Run" -modi drun,$modes
