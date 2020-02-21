#!/bin/bash

rm /tmp/screenshot.png > /dev/null 2>&1
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -scale 10% -scale 1000% /tmp/screenshotblur.png
i3lock -e -u -i /tmp/screenshotblur.png
