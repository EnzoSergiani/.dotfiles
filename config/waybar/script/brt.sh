#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

BL_PATH=$(find /sys/class/backlight -maxdepth 1 -mindepth 1 | head -1)

if [[ -n "$BL_PATH" ]]; then
  CUR=$(cat "$BL_PATH/brightness" 2>/dev/null)
  MAX=$(cat "$BL_PATH/max_brightness" 2>/dev/null)
  PCT=$((CUR * 100 / MAX))
else
  PCT=0
fi

printf "BRT%03d\n" "$(safe_num "$PCT")"
