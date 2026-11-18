#!/bin/bash
VIDEO_DIR="/home/l0wer/Videos"
mkdir -p "$VIDEO_DIR"
FILENAME="$VIDEO_DIR/gravacao_$(date +%Y%m%d_%H%M%S).mp4"

# Verifica se o wf-recorder já está rodando
if pgrep -x "wf-recorder" > /dev/null; then
    # Para a gravação
    pkill -INT wf-recorder
    sleep 1
    # Envia notificação para o SwayNC
    notify-send -a "Gravador" "Gravação Finalizada" "O vídeo foi salvo em: $VIDEO_DIR"
else
    # Inicia a gravação
    notify-send -a "Gravador" "Gravação Iniciada" "Gravando a tela e o áudio do sistema..."
    
    # Pega o monitor de áudio padrão do sistema (PipeWire/PulseAudio)
    AUDIO_SOURCE=$(pactl get-default-sink).monitor
    
    # Inicia o gravador em segundo plano
    wf-recorder -a "$AUDIO_SOURCE" -f "$FILENAME" &
fi
