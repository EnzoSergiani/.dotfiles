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
  ESSID=$(nmcli -f IN-USE,SSID dev wifi 2>/dev/null | awk '/^\*/{print $2}' | head -n1)
  [[ -z "$ESSID" ]] && ESSID="WiFi"
  SIGNAL=$(nmcli -f IN-USE,SIGNAL dev wifi 2>/dev/null | awk '/^\*/{print $2}' | head -n1)
  [[ -z "$SIGNAL" ]] && SIGNAL=0
  INDEX=$((SIGNAL * 8 / 100))
  [[ $INDEX -gt 8 ]] && INDEX=8

  TOOLTIP="${ESSID}\\nSignal: ${SIGNAL}%\\nIP: ${IP}\\n⇣${RX_SPEED} KB/s ⇡${TX_SPEED} KB/s"
  printf '{"text":"󰤨 %s","tooltip":"%s","class":"wifi"}\n' "${ICONS[$INDEX]}" "$TOOLTIP"
else
  TOOLTIP="Ethernet\\nIP: ${IP}\\n⇣${RX_SPEED} KB/s ⇡${TX_SPEED} KB/s"
  printf '{"text":"󰀂 󰪥","tooltip":"%s","class":"ethernet"}\n' "$TOOLTIP"
fi
