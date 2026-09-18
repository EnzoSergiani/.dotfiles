#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

ZONE=""
for z in /sys/class/thermal/thermal_zone*/; do
  TYPE=$(cat "${z}type" 2>/dev/null)
  if [[ "$TYPE" == "x86_pkg_temp" ]]; then
    ZONE="$z"
    break
  fi
done

if [[ -z "$ZONE" ]]; then
  ZONE=$(ls -d /sys/class/thermal/thermal_zone*/ 2>/dev/null | head -1)
fi

if [[ -n "$ZONE" && -f "${ZONE}temp" ]]; then
  RAW=$(cat "${ZONE}temp" 2>/dev/null)
  TMP=$((RAW / 1000))
else
  TMP=0
fi

TMP=$(safe_num "$TMP")
CLASS=$(class_high "$TMP" 75 85)
to_json "TMP$(printf '%03d' "$TMP")" "$CLASS" "Température: ${TMP}°C"
