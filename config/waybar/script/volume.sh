#!/run/current-system/sw/bin/bash
ICONS=("󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥")
PCT=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [[ "$MUTED" == "true" ]]; then
  echo "{\"text\":\"󰝦\",\"tooltip\":\"Muted\"}"
else
  INDEX=$((PCT * 8 / 100))
  [[ $INDEX -gt 8 ]] && INDEX=8
  echo "{\"text\":\"${ICONS[$INDEX]}\",\"tooltip\":\"Volume: $PCT%\"}"
fi
