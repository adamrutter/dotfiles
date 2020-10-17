#!/bin/bash

xrandr -s 1920x1080 --rate 144					          # Set resolution/refresh rate
xgamma -rgamma 0.9 -ggamma 0.85 -bgamma 0.95      # Colour calibration; must be run before redshift
xbindkeys                                         # Run xbindkeys; set keyboard bindings
xset s off; xset -dpms                            # Turn off screensaver and power saving
xrdb ~/.Xresources                                # Set xresources
redshift -l manual &                              # Start redshift; blue light filter
/home/adam/bin/mount-phone.sh &                   # Run script to automatically mount phone
picom --config ~/.config/picom/picom.conf &       # Start picom; compositing manager
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0         # Fix for fullscreen games; Allows workspaces to be changed without the game disappearing
xset b off                                        # Turn terminal bong off for X
export QT_STYLE_OVERRIDE=gtk2                     # Force Qt applications to use the GTK theme
/usr/lib/kdeconnectd &                            # Start KDE Connect
/home/adam/bin/mouse-acceleration.sh off          # Turn mouse acceleration off
/home/adam/bin/mouse-sensitivity.sh -0.2          # Set mouse sensitivity
/home/adam/bin/audio-notify.sh &                  # Notification daemon for audio players
flashfocus --flash-on-focus &                     # Window focus animations
/usr/lib/gsd-xsettings &                          # For load/hot reload of GTK
sh ~/.fehbg &                                     # Set wallpaper
change_gtk.sh -t=`cat ~/.cache/theme_gtk_theme`   # Set GTK theme
change_gtk.sh -i=`cat ~/.cache/theme_icon_theme`  # Set icon theme
wal -n -R                                         # Set pywal theme
source ~/.api_keys                                # Source API keys for awesome
exec awesome                                      # Load awesome
