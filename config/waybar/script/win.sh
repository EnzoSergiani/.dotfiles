#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

MAX_LEN=12

CLASS=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty')

if [[ -z "$CLASS" ]]; then
  DISPLAY_NAME=$(center_text "NO ACTIVITY" "$MAX_LEN")
  to_json "$DISPLAY_NAME" "" "Aucune fenêtre"
  exit 0
fi

CLASS_CLEAN="${CLASS#org.gnome.}"

if ((${#CLASS_CLEAN} > MAX_LEN)); then
  DISPLAY_NAME="${CLASS_CLEAN:0:$((MAX_LEN - 1))}…"
  DISPLAY_NAME=$(center_text "$DISPLAY_NAME" "$MAX_LEN")
else
  DISPLAY_NAME=$(center_text "$CLASS_CLEAN" "$MAX_LEN")
fi

to_json "$DISPLAY_NAME" "" "$CLASS"
