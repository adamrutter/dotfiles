#!/bin/sh
# Originally from https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/pulseaudio-tail
# Updated to add notifications and sounds, and some other modifications which have been noted

# My added functions/variable
volume() {
  local VOLUME=$(pamixer --get-volume --sink $sink)
  echo $VOLUME
}

play_sound() {
  canberra-gtk-play -i audio-volume-change
}

# From https://github.com/Fabian-G/dotfiles/blob/master/scripts/bin/getProgressString
# Usage: progress_bar <TOTAL ITEMS> <FILLED LOOK> <NOT FILLED LOOK> <STATUS>
progress_bar() {
  ITEMS="$1" # The total number of items(the width of the bar)
  FILLED_ITEM="$2" # The look of a filled item
  NOT_FILLED_ITEM="$3" # The look of a not filled item
  STATUS="$4" # The current progress status in percent

  # calculate how many items need to be filled and not filled
  FILLED_ITEMS=$(echo "((${ITEMS} * ${STATUS})/100 + 0.5) / 1" | bc)
  NOT_FILLED_ITEMS=$(echo "$ITEMS - $FILLED_ITEMS" | bc)

  # Assemble the bar string
  msg=$(printf "%${FILLED_ITEMS}s" | sed "s| |${FILLED_ITEM}|g")
  msg=${msg}$(printf "%${NOT_FILLED_ITEMS}s" | sed "s| |${NOT_FILLED_ITEM}|g")
  echo "$msg"
}

bar_color_filled="#dfe1e8"
bar_color_not_filled="#2b303b"
bar_glyph="▌"

notification() {
  dunstify "Volume notification" "$(progress_bar 50 "<span foreground='$bar_color_filled'>$bar_glyph</span>" "<span foreground='$bar_color_not_filled'>$bar_glyph</span>" $(volume))" -r 54902 -u low
}

ICON_COLOUR="#a7adba"
ICON_1=
ICON_2=
ICON_3=
ICON_4=
ICON_MUTED=
icon() {
  echo "%{F$ICON_COLOUR}%{T6}$(eval echo \$ICON_$1)%{T-}%{F-}"
}

AMOUNT=2 # The amount to increment volume by

# Original script starts here
update_sink() {
    sink=$(pacmd list-sinks | sed -n '/\* index:/ s/.*: //p')
}

volume_up() {
    update_sink
    # Use an if statment so the sound doesn't play when already at 100%
    if [[ $(volume) -lt 100 ]]; then
      pamixer --sink "$sink" --increase $AMOUNT # Added own increment variable/changed to pamixer
      play_sound
    fi
}

volume_down() {
    update_sink
    # Use an if statment so the sound doesn't play when already at 0%
    if [[ $(volume) -gt 0 ]]; then
      pamixer --sink "$sink" --decrease $AMOUNT # Added own increment variable/changed to pamixer
      play_sound
    fi
}

volume_mute() {
    update_sink
    pamixer --sink "$sink" --toggle-mute # Changed to pamixer
    play_sound
}

volume_print() {
    update_sink

    # Commented out this section for setting the output, added own logic below
    # active_port=$(pacmd list-sinks | sed -n "/index: $sink/,/index:/p" | grep active)
    # if echo "$active_port" | grep -q speaker; then
    #     icon="#1"
    # elif echo "$active_port" | grep -q headphones; then
    #     icon="#2"
    # else
    #     icon="#3"
    # fi
    #
    # muted=$(pamixer --sink "$sink" --get-mute)
    #
    # if [ "$muted" = true ]; then
    #     echo "$icon --"
    # else
    #     echo "$icon $(pamixer --sink "$sink" --get-volume)"
    # fi

    # My own logic for setting the output
    if [[ $(pamixer --get-volume-human --sink $sink) == "muted" ]]; then
      echo "$(icon "MUTED")  0%"
    elif [[ $(volume) -ge 0 && $(volume) -le 24 ]]; then
      echo "$(icon "1")  $(volume)%"
    elif [[ $(volume) -ge 25 && $(volume) -le 49 ]]; then
      echo "$(icon "2")  $(volume)%"
    elif [[ $(volume) -ge 50 && $(volume) -le 74 ]]; then
      echo "$(icon "3")  $(volume)%"
    elif [[ $(volume) -ge 75 && $(volume) -le 100 ]]; then
      echo "$(icon "4")  $(volume)%"
    fi
}

listen() {
    volume_print

    # pactl subscribe | while read -r event; do
    #     if echo "$event" | grep -qv "Client"; then
    #         volume_print
    #     fi
    # done

    # From https://github.com/polybar/polybar-scripts/issues/27
    # For improved performance
    pactl subscribe | grep --line-buffered "sink" | while read -r e; do
        volume_print;
    done
}

case "$1" in
    --up)
        volume_up
        notification
        ;;
    --down)
        volume_down
        notification
        ;;
    --mute)
        volume_mute
        ;;
    *)
        listen
        ;;
esac
