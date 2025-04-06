#!/bin/bash

WALLPAPER_DIRECTORY=~/.config/backgrounds/

WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER"

