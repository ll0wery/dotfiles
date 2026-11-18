#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SELECTION=$(ls -1 "$WALLPAPER_DIR" | /usr/bin/rofi -dmenu -i -p "Wallpaper:")

if [ -z "$SELECTION" ]; then
    exit 0
fi

IMAGE_PATH="$WALLPAPER_DIR/$SELECTION"

# 1. Salva a configuração usando a vírgula (aplica em qualquer monitor)
echo "preload = $IMAGE_PATH" > $HOME/.config/hypr/hyprpaper.conf
echo "wallpaper = ,$IMAGE_PATH" >> $HOME/.config/hypr/hyprpaper.conf
echo "splash = false" >> $HOME/.config/hypr/hyprpaper.conf

# 2. Mata o hyprpaper e inicia ele de novo
pkill -9 hyprpaper
sleep 1
hyprpaper &

# 3. Força a aplicação via hyprctl (O segredo para funcionar na hora)
sleep 1
hyprctl hyprpaper preload "$IMAGE_PATH"
hyprctl hyprpaper wallpaper ",$IMAGE_PATH"

# 4. Gera as cores
/usr/bin/wal -i "$IMAGE_PATH" -n -q

# 5. Atualiza Vis e Cava
cat ~/.cache/wal/colors > ~/.config/vis/colors/pywal 2>/dev/null
killall -USR1 vis 2>/dev/null

# 6. Atualiza Kitty, Waybar e Bordas
sleep 1
kill -SIGUSR1 $(pidof kitty) 2>/dev/null
pkill -SIGUSR2 waybar 2>/dev/null

COLOR_HEX=$(grep -oP '(?<=@define-color color4 ).*(?=;)' $HOME/.cache/wal/colors-waybar.css 2>/dev/null | head -n 1 | tr -d '\n')
if [ -n "$COLOR_HEX" ]; then
    HEX_CLEAN=$(echo "$COLOR_HEX" | tr -d '#')
    hyprctl keyword general:col.active_border "rgba(${HEX_CLEAN}ff)" > /dev/null
fi
