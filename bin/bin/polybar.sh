#!/bin/bash

killall -q polybar
polybar bottom &
#ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-bottom
