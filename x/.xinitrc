#!/bin/bash
xbindkeys                                 # Run xbindkeys; set keyboard bindings
xrdb ~/.Xresources                        # Set xresources
redshift -l manual &                      # Start redshift; blue light filter
export QT_STYLE_OVERRIDE=gtk2             # Force Qt applications to use the GTK theme
/usr/lib/kdeconnectd &                    # Start KDE Connect
/home/adam/bin/mouse-acceleration.sh off  # Turn mouse acceleration off
/home/adam/bin/mouse-sensitivity.sh -0.2  # Set mouse sensitivity
flashfocus --flash-on-focus &             # Window focus animations
wal -n -R                                 # Set pywal theme
source ~/.api_keys                        # Source API keys for awesome
pygrid &                                  # For psuedo tiling
exec cinnamon-session                     # Start cinnamon

