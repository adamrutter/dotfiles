#!/bin/sh
# Originally from https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/pulseaudio-tail
# Updated to add notifications and sounds, and some other modifications which have been noted

# My added functions/variable
play_sound() {
  canberra-gtk-play -i audio-volume-change
}

volume() {
  local VOLUME=$(pamixer --get-volume --sink $sink)
  echo $VOLUME
}

ICON_COLOUR="#a7adba"
ICON_1=
ICON_2=
ICON_3=
ICON_4=
ICON_MUTED=

AMOUNT=2 # The amount to increment volume by

# Original script starts here
update_sink() {
    sink=$(pacmd list-sinks | sed -n '/\* index:/ s/.*: //p')
}

volume_up() {
    update_sink
    pactl set-sink-volume "$sink" +$AMOUNT% # Added own increment variable
}

volume_down() {
    update_sink
    pactl set-sink-volume "$sink" -$AMOUNT% # Added own increment variable
}

volume_mute() {
    update_sink
    pactl set-sink-mute "$sink" toggle
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
      echo "%{F$ICON_COLOUR}$ICON_MUTED%{F-}  0%"
    elif [[ $(volume) -ge 0 && $(volume) -le 24 ]]; then
      echo "%{F$ICON_COLOUR}$ICON_1%{F-}  $(volume)%"
    elif [[ $(volume) -ge 25 && $(volume) -le 49 ]]; then
      echo "%{F$ICON_COLOUR}$ICON_2%{F-}  $(volume)%"
    elif [[ $(volume) -ge 50 && $(volume) -le 74 ]]; then
      echo "%{F$ICON_COLOUR}$ICON_3%{F-}  $(volume)%"
    elif [[ $(volume) -ge 75 && $(volume) -le 100 ]]; then
      echo "%{F$ICON_COLOUR}$ICON_4%{F-}  $(volume)%"
    fi
}

listen() {
    volume_print

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -qv "Client"; then
            volume_print
        fi
    done
}

case "$1" in
    --up)
        volume_up
        play_sound
        ;;
    --down)
        volume_down
        play_sound
        ;;
    --mute)
        volume_mute
        play_sound
        ;;
    *)
        listen
        ;;
esac
