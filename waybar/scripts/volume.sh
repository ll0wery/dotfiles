#!/bin/bash
if [ "$1" = "up" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
elif [ "$1" = "down" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
elif [ "$1" = "toggle" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
    vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if [[ "$vol_info" == *"[MUTED]"* ]]; then
        echo "{\"text\": \" Mudo\", \"class\": \"muted\"}"
        exit 0
    fi
    vol_float=$(echo "$vol_info" | awk "{print \$2}")
    vol=$(echo "$vol_float * 100" | bc | cut -d"." -f1)
    
    full=$((vol / 10))
    empty=$((10 - full))
    bar=""
    for ((i=0; i<full; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    
    echo "{\"text\": \" $bar ${vol}%\"}"
fi
