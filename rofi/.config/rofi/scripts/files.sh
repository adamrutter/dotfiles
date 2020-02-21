#!/bin/bash

# Output a cached list of files/directories, and then pass the selected one as an argument to xdg-open
# The cache is generated using fd and cron

if [[ -z "$@" ]]; then
  # Print
  cat ~/.fd-cache
else
  # Do
  case "$1" in
    *)
      coproc ( xdg-open "$1" & > /dev/null  2>&1 )
      ;;
  esac
fi
