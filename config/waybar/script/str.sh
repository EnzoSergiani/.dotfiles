#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

PCT=$(df --output=pcent / 2>/dev/null | tail -1 | tr -dc '0-9')

PCT=$(safe_num "$PCT")
CLASS=$(class_high "$PCT" 85 95)
to_json "STR$(printf '%03d' "$PCT")" "$CLASS" "Stockage: ${PCT}%"
