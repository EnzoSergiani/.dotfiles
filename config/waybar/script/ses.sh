#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

USER_NAME=$(whoami | tr '[:lower:]' '[:upper:]')

LOGIN_TIME=$(who | grep "$(whoami)" | head -1 | awk '{print $3, $4}')
LOGIN_EPOCH=$(date -d "$LOGIN_TIME" +%s 2>/dev/null)
NOW_EPOCH=$(date +%s)

if [[ -z "$LOGIN_EPOCH" ]]; then
  printf "%s-UP00:00-W??/??-X????-Y????\n" "$USER_NAME"
  exit 0
fi

DELTA=$((NOW_EPOCH - LOGIN_EPOCH))
HOURS=$((DELTA / 3600))
MINUTES=$(((DELTA % 3600) / 60))

STATE=$(get_hypr_state)
WORKSPACE_ID=$(jq -r '.active.id // 0' <<<"$STATE")
WORKSPACE=$(workspace_index "$WORKSPACE_ID")
WORKSPACE_MAX=$(jq '.workspaces | length' <<<"$STATE")

CURSOR=$(hyprctl cursorpos -j 2>/dev/null)
CX=$(jq -r '.x // 0' <<<"$CURSOR")
CY=$(jq -r '.y // 0' <<<"$CURSOR")

printf "%s-UP%02d:%02d-W%02d/%02d-X%04d-Y%04d\n" "$USER_NAME" "$(safe_num "$HOURS")" "$(safe_num "$MINUTES")" "$(safe_num "$WORKSPACE")" "$(safe_num "$WORKSPACE_MAX")" "$(safe_num "$CX")" "$(safe_num "$CY")"
