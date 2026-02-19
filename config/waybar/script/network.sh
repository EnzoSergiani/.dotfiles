#!/run/current-system/sw/bin/bash
ICONS=("󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥")
CACHE="/tmp/waybar_network_cache"

INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

if [[ -z "$INTERFACE" ]]; then
  printf '{"text":"󰤮 󰝦","tooltip":"Disconnected","class":"disconnected"}\n'
  exit 0
fi

IP=$(ip addr show "$INTERFACE" | grep "inet " | awk '{print $2}' | head -n1)
[[ -z "$IP" ]] && IP="N/A"

RX_NOW=$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes 2>/dev/null)
TX_NOW=$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes 2>/dev/null)
TIME_NOW=$(date +%s)

if [[ -f "$CACHE" ]]; then
  RX_PREV=$(awk 'NR==1' "$CACHE")
  TX_PREV=$(awk 'NR==2' "$CACHE")
  TIME_PREV=$(awk 'NR==3' "$CACHE")
  ELAPSED=$((TIME_NOW - TIME_PREV))
  [[ $ELAPSED -lt 1 ]] && ELAPSED=1
  RX_SPEED=$(((RX_NOW - RX_PREV) / 1024 / ELAPSED))
  TX_SPEED=$(((TX_NOW - TX_PREV) / 1024 / ELAPSED))
else
  RX_SPEED=0
  TX_SPEED=0
fi

printf '%s\n%s\n%s\n' "$RX_NOW" "$TX_NOW" "$TIME_NOW" >"$CACHE"

if [[ "$INTERFACE" == w* ]]; then
  ESSID=$(nmcli dev show "$INTERFACE" 2>/dev/null | grep "GENERAL.CONNECTION" | awk -F': ' '{print $2}' | xargs)
  [[ -z "$ESSID" ]] && ESSID="WiFi"

  SIGNAL=$(iw dev "$INTERFACE" link 2>/dev/null | grep signal | awk '{print $2}')
  if [[ -n "$SIGNAL" ]]; then
    PCT=$(((SIGNAL + 110) * 100 / 70))
    [[ $PCT -lt 0 ]] && PCT=0
    [[ $PCT -gt 100 ]] && PCT=100
  else
    PCT=50
  fi

  INDEX=$((PCT * 8 / 100))
  [[ $INDEX -gt 8 ]] && INDEX=8

  TOOLTIP="${ESSID}\\nSignal: ${PCT}%\\nIP: ${IP}\\n⇣${RX_SPEED} KB/s ⇡${TX_SPEED} KB/s"
  printf '{"text":"󰤨 %s","tooltip":"%s","class":"wifi"}\n' "${ICONS[$INDEX]}" "$TOOLTIP"
else
  TOOLTIP="Ethernet\\nIP: ${IP}\\n⇣${RX_SPEED} KB/s ⇡${TX_SPEED} KB/s"
  printf '{"text":"󰀂 󰪥","tooltip":"%s","class":"ethernet"}\n' "$TOOLTIP"
fi
