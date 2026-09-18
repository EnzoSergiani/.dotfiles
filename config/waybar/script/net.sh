#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

IFACE=$(default_iface)

if [[ -z "$IFACE" ]]; then
  to_json "DISC-U---:D---" "disconnected" "Aucune connexion réseau"
  exit 0
fi

CACHE="/tmp/waybar-net-cache-${IFACE}"
NOW=$(date +%s%N)
RX_NOW=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes 2>/dev/null || echo 0)
TX_NOW=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes 2>/dev/null || echo 0)

if [[ -f "$CACHE" ]]; then
  read -r PREV_TIME PREV_RX PREV_TX <"$CACHE"
else
  PREV_TIME="$NOW"
  PREV_RX="$RX_NOW"
  PREV_TX="$TX_NOW"
fi

echo "$NOW $RX_NOW $TX_NOW" >"$CACHE"

DELTA_TIME_NS=$((NOW - PREV_TIME))
DELTA_RX=$((RX_NOW - PREV_RX))
DELTA_TX=$((TX_NOW - PREV_TX))

if [[ $DELTA_TIME_NS -le 0 || $DELTA_RX -lt 0 || $DELTA_TX -lt 0 ]]; then
  DOWN=0
  UP=0
else
  DOWN=$(awk -v db="$DELTA_RX" -v dt="$DELTA_TIME_NS" \
    'BEGIN { printf "%d", db / (dt / 1000000000) / 1024 }')
  UP=$(awk -v db="$DELTA_TX" -v dt="$DELTA_TIME_NS" \
    'BEGIN { printf "%d", db / (dt / 1000000000) / 1024 }')
fi

[[ $DOWN -gt 999 ]] && DOWN=999
[[ $UP -gt 999 ]] && UP=999

if [[ "$IFACE" == wl* ]]; then
  SIGNAL_DBM=$(iw dev "$IFACE" link 2>/dev/null | awk '/signal:/ {print $2}')
  if [[ -n "$SIGNAL_DBM" ]]; then
    SIGNAL=$(awk -v dbm="$SIGNAL_DBM" 'BEGIN {
      p=(dbm+90)*100/60;
      if (p<0) p=0;
      if (p>100) p=100;
      printf "%d", p
    }')
  else
    SIGNAL=0
  fi
  printf -v TEXT "W%03d-U%03d:D%03d" \
    "$(safe_num "$SIGNAL")" \
    "$(safe_num "$UP")" \
    "$(safe_num "$DOWN")"
elif [[ "$IFACE" == en* ]]; then
  printf -v TEXT "E000-U%03d:D%03d" \
    "$(safe_num "$UP")" \
    "$(safe_num "$DOWN")"
else
  printf -v TEXT "N000-U%03d:D%03d" \
    "$(safe_num "$UP")" \
    "$(safe_num "$DOWN")"
fi

to_json "$TEXT" "" "Interface: $IFACE | ↓ ${DOWN}K/s ↑ ${UP}K/s"
