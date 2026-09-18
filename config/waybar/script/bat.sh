#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

BAT_PATH=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -1)

if [[ -n "$BAT_PATH" ]]; then
  CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null)
  STATUS=$(cat "$BAT_PATH/status" 2>/dev/null)
else
  CAPACITY=0
  STATUS="Unknown"
fi

CAPACITY=$(safe_num "$CAPACITY")

if [[ "$STATUS" == "Charging" ]]; then
  PREFIX="CHR"
  CLASS="charging"
  TOOLTIP="En charge: ${CAPACITY}%"
else
  PREFIX="BAT"
  if [[ "$STATUS" == "Full" || "$STATUS" == "Not charging" ]]; then
    CLASS=""
  else
    CLASS=$(class_low "$CAPACITY" 35 20)
  fi
  TOOLTIP="Batterie: ${CAPACITY}%"
fi

printf -v TEXT "%s%03d" "$PREFIX" "$CAPACITY"
to_json "$TEXT" "$CLASS" "$TOOLTIP"
