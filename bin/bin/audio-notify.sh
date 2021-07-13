#!/bin/bash

# Wait for a change in the track title or play/pause status, then run notify-send
playerctl --player=spotify,rhythmbox metadata --format '{{ title }} {{ status }}' --follow | while read OUTPUT; do
	# Only send a notification is the track is playing
	if [[ $OUTPUT == *"Playing" ]]; then
		# Notification heading
		HEADING=$(playerctl --player=spotify,rhythmbox metadata --format '{{ title }}')
		# Notification body; album name (name of podcast) if a podcast, otherwise artist name
		if [[ $(playerctl --player=spotify,rhythmbox metadata --format '{{ mpris:trackid }}') == "spotify:episode"* ]] || [[ $(playerctl --player=rhythmbox metadata | grep genre) == *"Podcast"* ]]; then
			BODY=$(playerctl --player=spotify,rhythmbox metadata --format '{{ album }}')
		else
			BODY=$(playerctl --player=spotify,rhythmbox metadata --format '{{ artist }}')
		fi
		# playerctl fires the same event on closing as it does when changing track (but blank), so only
		# run if $BODY has been set; ie. don't show a blank notification upon closing Spotify
		# Uses a notify-send replacement to allow for replacement notifications, rather than the standard stacking
		if [[ $BODY ]]; then
			/home/adam/bin/notify-send.sh -u low --replace-file=/tmp/spotify-notification "$HEADING" "$BODY"
		fi
	fi
done
