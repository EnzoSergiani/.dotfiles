#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

read -r _ TOTAL _ < <(grep MemTotal /proc/meminfo)
read -r _ AVAIL _ < <(grep MemAvailable /proc/meminfo)

if [[ -z "$TOTAL" || "$TOTAL" -eq 0 ]]; then
  PCT=0
else
  PCT=$((100 * (TOTAL - AVAIL) / TOTAL))
fi

PCT=$(safe_num "$PCT")
CLASS=$(class_high "$PCT" 85 95)
to_json "MEM$(printf '%03d' "$PCT")" "$CLASS" "Mémoire: ${PCT}%"
