#!/bin/bash

killall -q polybar
polybar top &
#ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-bottom
