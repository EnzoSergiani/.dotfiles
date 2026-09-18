#!/usr/bin/env bash
source "$(dirname "$0")/utils.sh"

IN_NOTIFY=0
STRING_COUNT=0
APP_NAME=""
SUMMARY=""

while IFS= read -r line; do
  if [[ "$line" == *"Interface=org.freedesktop.Notifications"* && "$line" == *"Member=Notify"* ]]; then
    IN_NOTIFY=1
    STRING_COUNT=0
    APP_NAME=""
    SUMMARY=""
    continue
  fi

  if [[ "$IN_NOTIFY" -eq 1 ]]; then
    if [[ "$line" =~ STRING\ \"(.*)\"\; ]]; then
      VAL="${BASH_REMATCH[1]}"
      case "$STRING_COUNT" in
      0) APP_NAME="$VAL" ;;
      2) SUMMARY="$VAL" ;;
      esac
      STRING_COUNT=$((STRING_COUNT + 1))

      if [[ "$STRING_COUNT" -ge 3 ]]; then
        if [[ -n "$SUMMARY" ]]; then
          if [[ -n "$APP_NAME" ]]; then
            queue_message "${APP_NAME}: ${SUMMARY}"
          else
            queue_message "${SUMMARY}"
          fi
        fi
        IN_NOTIFY=0
      fi
    fi
  fi
done < <(busctl --user monitor org.freedesktop.Notifications 2>/dev/null)
