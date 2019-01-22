# Set path
set PATH /home/adam/bin $PATH

# Turn terminal bong off for TTY
# setterm -blength 0

# Set welcome message to empty/nothing
set fish_greeting

# Set vim as the default terminal editor
set -gx EDITOR vim

# Stop wine from adding filetype associations
set -gx WINEDLLOVERRIDES winemenubuilder.exe=d
