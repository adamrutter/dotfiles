#!/bin/bash

xgamma -rgamma 0.9 -ggamma 0.85 -bgamma 0.95      # Colour calibration; must be run before redshift
source /etc/X11/Xsession.d/*                      # Source all files in Xsession.d
# /home/adam/bin/set-resolution                   # Add and set resolution using xrandr; only needed when using nouveau drivers
# setxkbmap -layout us                            # Set keyboard layout
xbindkeys                                         # Run xbindkeys; set keyboard bindings
sh ~/.fehbg &                                     # Set wallpaper
xset s off; xset -dpms                            # Turn off screensaver and power saving
nvidia-settings --load-config-only                # Load Nvidia driver settings
# numlockx on                                       # Set Num Lock
xrdb ~/.Xresources                                # Set xresources
# xsetroot -cursor_name left_ptr                    # Set root window cursor
redshift -l manual &                              # Start redshift; blue light filter
/home/adam/bin/mount-phone.sh &                   # Run script to automatically mount phone
nemo -n &                                         # Start Nemo daemon
~/bin/picom-sdhand --config ~/.config/picom/picom.conf & # Start picom; compositing manager
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0         # Fix for fullscreen games in i3; Allows workspaces to be changed without the game disappearing
xset b off                                        # Turn terminal bong off for X
export QT_STYLE_OVERRIDE=gtk2                     # Force Qt applications to use the GTK theme
/usr/lib/x86_64-linux-gnu/libexec/kdeconnectd &   # Start KDE Connect
dunst &                                           # Start dunst; notification server
/home/adam/bin/mouse-acceleration.sh off          # Turn mouse acceleration off
/home/adam/bin/mouse-sensitivity.sh -0.2          # Set mouse sensitivity
/home/adam/bin/playerctl-notify.sh &              # Notification daemon for Spotify
exec i3                                           # Load i3
