#!/usr/bin/env bash

# initializing wallpaper daemon
swww-daemon &

# setting wallpaper
swww img ~/Pictures/highres-Elaina.jpg &

#the bar
waybar &

#dunst
dunst
