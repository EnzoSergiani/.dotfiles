#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

read -r _ u1 n1 s1 i1 _ </proc/stat
sleep 0.3
read -r _ u2 n2 s2 i2 _ </proc/stat

TOTAL=$(((u2 + n2 + s2 + i2) - (u1 + n1 + s1 + i1)))
IDLE=$((i2 - i1))

if [[ $TOTAL -le 0 ]]; then
  PCT=0
else
  PCT=$((100 * (TOTAL - IDLE) / TOTAL))
fi

PCT=$(safe_num "$PCT")
CLASS=$(class_high "$PCT" 85 95)
to_json "CPU$(printf '%03d' "$PCT")" "$CLASS" "CPU: ${PCT}%"
