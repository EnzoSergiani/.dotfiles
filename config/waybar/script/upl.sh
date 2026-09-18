#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

IFACE=$(default_iface)
[[ -z "$IFACE" ]] && {
  printf "UPL000\n"
  exit 0
}

T1=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes 2>/dev/null || echo 0)
sleep 0.5
T2=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes 2>/dev/null || echo 0)

R1=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes 2>/dev/null || echo 0)
sleep 0.5
R2=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes 2>/dev/null || echo 0)

KBST=$(((T2 - T1) * 2 / 1024))
KBSR=$(((R2 - R1) * 2 / 1024))

printf "%d:%d\n" "$(safe_num "$KBST")" "$(safe_num "$KBSR")"
