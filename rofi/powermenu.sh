#!/bin/bash

# Obtém o perfil atual para mostrar no menu
current_profile=$(powerprofilesctl get)

options=" Desligar\n Reiniciar\n Hibernar\n Sair\n---\n"
options+="⚡ Máximo Desempenho (Performance)\n"
options+="⚖️ Equilibrado (Balanced)\n"
options+="🍃 Máxima Economia (Power Saver)"

# Abre o Rofi
chosen=$(echo -e "$options" | rofi -dmenu -p "Sistema (Perfil atual: $current_profile):")

# Executa a ação baseada na escolha
case "$chosen" in
    " Desligar") systemctl poweroff ;;
    " Reiniciar") systemctl reboot ;;
    " Hibernar") systemctl hibernate ;;
    " Sair") hyprctl dispatch exit ;;
    "⚡ Máximo Desempenho (Performance)") powerprofilesctl set performance; notify-send "Perfil de Energia" "Alterado para: Máximo Desempenho" ;;
    "⚖️ Equilibrado (Balanced)") powerprofilesctl set balanced; notify-send "Perfil de Energia" "Alterado para: Equilibrado" ;;
    "🍃 Máxima Economia (Power Saver)") powerprofilesctl set power-saver; notify-send "Perfil de Energia" "Alterado para: Máxima Economia" ;;
esac
