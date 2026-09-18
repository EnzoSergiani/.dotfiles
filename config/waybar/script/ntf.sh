#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

WIDTH=33
CACHE_SCROLL="/tmp/waybar-ntf-scroll"

NTF=$(get_current_queued_message)

if [[ -z "$NTF" ]]; then
  SES=$("$(dirname "$0")/ses.sh")

  if [[ -n "$SES" ]]; then
    EMPTY="$SES"
  else
    EMPTY="SYSTEMS NOMINAL"
  fi

  if ((${#EMPTY} <= WIDTH)); then
    DISPLAY=$(center_text "$EMPTY" "$WIDTH")
  else
    PADDED="${EMPTY}   •   "
    PLEN=${#PADDED}
    DOUBLED="${PADDED}${PADDED}"
    POS=0
    [[ -f "$CACHE_SCROLL" ]] && POS=$(cat "$CACHE_SCROLL")
    [[ "$POS" -ge "$PLEN" ]] && POS=0
    DISPLAY="${DOUBLED:$POS:$WIDTH}"
    NEXT=$(((POS + 1) % PLEN))
    echo "$NEXT" >"$CACHE_SCROLL"
  fi

  to_json "$DISPLAY" "" "Fenêtre active"
  exit 0
fi

if ((${#NTF} <= WIDTH)); then
  DISPLAY=$(center_text "$NTF" "$WIDTH")
else
  PADDED="${NTF}   •   "
  PLEN=${#PADDED}
  DOUBLED="${PADDED}${PADDED}"
  POS=0
  [[ -f "$CACHE_SCROLL" ]] && POS=$(cat "$CACHE_SCROLL")
  [[ "$POS" -ge "$PLEN" ]] && POS=0
  DISPLAY="${DOUBLED:$POS:$WIDTH}"
  NEXT=$(((POS + 1) % PLEN))
  echo "$NEXT" >"$CACHE_SCROLL"
fi

to_json "$DISPLAY" "notify" "$NTF"
