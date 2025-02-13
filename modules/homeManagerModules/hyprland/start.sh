#!/usr/bin/env bash

# initializing wallpaper daemon
swww-daemon &

# setting wallpaper
swww img ~/Pictures/anby.png &

#the bar
waybar &

#dunst
dunst
