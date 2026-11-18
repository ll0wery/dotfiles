#!/bin/bash
sleep 2
pkill -9 hyprpaper
sleep 1
hyprpaper &

if [ -f ~/.cache/wal/wal ]; then
    IMAGE_PATH=$(cat ~/.cache/wal/wal)
else
    IMAGE_PATH="/home/l0wer/Pictures/Wallpapers/sla6.png"
fi

hyprctl hyprpaper wallpaper ",$IMAGE_PATH"

# Atualiza a cor das bordas com o Pywal
COLOR_HEX=$(grep -oP '(?<=@define-color color4 ).*(?=;)' $HOME/.cache/wal/colors-waybar.css | head -n 1 | tr -d '\n')
if [ -n "$COLOR_HEX" ]; then
    HEX_CLEAN=$(echo "$COLOR_HEX" | tr -d '#')
    hyprctl keyword general:col.active_border "rgba(${HEX_CLEAN}ff)" > /dev/null
fi
