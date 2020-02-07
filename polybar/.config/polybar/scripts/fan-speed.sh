#!/bin/sh

speed=$(sensors | grep -efan{1..3} | head -n 3 | cut -d " " -f20)
echo ${speed}
