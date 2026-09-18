#!/usr/bin/env bash
STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

if echo "$STATE" | grep -q "MUTED"; then
  printf "MIC0\n"
else
  printf "MIC1\n"
fi
