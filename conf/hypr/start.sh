#!/usr/bin/env bash

# initializing wallpaper daemon
swww-daemon &

# setting wallpaper
swww img ~/.dotFiles/conf/Pictures/anby.jpg &

#the bar
waybar &

#dunst
dunst
