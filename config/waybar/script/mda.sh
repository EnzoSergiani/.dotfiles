#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

WIDTH=31
CACHE="/tmp/waybar-media-scroll"

center_text() {
  local text="$1" width="$2"
  local len=${#text}
  local total_padding=$((width - len))
  local left=$((total_padding / 2))
  local right=$((total_padding - left))
  printf '%*s%s%*s' "$left" "" "$text" "$right" ""
}

STATUS=$(playerctl status 2>/dev/null)
META=$(playerctl metadata --format '{{title}}||{{artist}}' 2>/dev/null)
TITLE="${META%%||*}"
ARTIST="${META##*||}"
[[ "$TITLE" == "$ARTIST" ]] && ARTIST=""

if [[ -z "$STATUS" || -z "$TITLE" ]]; then
  DISPLAY=$(center_text "NO TAPE" "$WIDTH")
  to_json "$DISPLAY" "" "Aucun média en cours"
  exit 0
fi

FULL="${ARTIST:+$ARTIST - }${TITLE}"

CLASS=""
[[ "$STATUS" == "Paused" ]] && CLASS="paused"

if ((${#FULL} <= WIDTH)); then
  DISPLAY=$(center_text "$FULL" "$WIDTH")
else
  PADDED="${FULL}   •   "
  PLEN=${#PADDED}
  DOUBLED="${PADDED}${PADDED}"
  if [[ -f "$CACHE" ]]; then
    POS=$(cat "$CACHE")
  else
    POS=0
  fi
  [[ "$POS" -ge "$PLEN" ]] && POS=0
  DISPLAY="${DOUBLED:$POS:$WIDTH}"
  if [[ "$STATUS" != "Paused" ]]; then
    NEXT=$(((POS + 1) % PLEN))
    echo "$NEXT" >"$CACHE"
  fi
fi

to_json "$DISPLAY" "$CLASS" "$FULL"
