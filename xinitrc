#!/bin/bash

setxkbmap -layout gb                      # Set keyboard layout
xbindkeys                                 # Run xbindkeys; set keyboard bindings
sh ~/.fehbg &                             # Set wallpaper
xset s off; xset -dpms                    # Turn off screensaver and power saving
numlockx on                               # Set Num Lock
nvidia-settings --load-config-only        # Load Nvidia driver settings
xrdb ~/.Xresources                        # Set xresources
xsetroot -cursor_name left_ptr            # Set root window cursor
redshift -l geoclue2 &		                # Start redshift; blue light filter
/opt/urserver/urserver-start &            # Start Unified Remote; for controlling computer from phone
/home/adam/bin/mount-phone &              # Run script to automatically mount phone
nemo -n &                                 # Start Nemo daemon
compton &                        		      # Start Compton; compositing manager
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 # Fix for fullscreen games in i3; Allows workspaces to be changed without the game disappearing
xset b off                                # Turn terminal bong off for X

exec i3						                        # Load i3; window manager
