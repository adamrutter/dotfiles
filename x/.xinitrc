#!/bin/bash

# Source xprofile
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session
