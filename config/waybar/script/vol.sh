#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [[ "$INFO" == *"[MUTED]"* ]]; then
  echo "VOL---"
  exit 0
fi

RAW=$(grep -oP '(?<=Volume: )[\d.]+' <<<"$INFO")
VOL=$(awk -v r="${RAW:-0}" 'BEGIN { printf "%d", r * 100 }')

printf "VOL%03d\n" "$(safe_num "$VOL")"
