#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

FAN_PATH=$(find /sys/class/hwmon -name 'fan1_input' 2>/dev/null | head -1)

if [[ -n "$FAN_PATH" ]]; then
  FAN=$(cat "$FAN_PATH" 2>/dev/null)
else
  FAN=0
fi

printf "FAN%d\n" "$(safe_num "$FAN")"
