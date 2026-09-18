#!/usr/bin/env bash

source "$(dirname "$0")/utils.sh"

ADAPTER=$(busctl tree org.bluez 2>/dev/null | grep -oP '/org/bluez/hci\d+' | head -1)

if [[ -z "$ADAPTER" ]]; then
  to_json "BLT0" "" "Aucun adaptateur bluetooth détecté"
  exit 0
fi

POWERED=$(busctl get-property org.bluez "$ADAPTER" org.bluez.Adapter1 Powered 2>/dev/null | awk '{print $2}')

if [[ "$POWERED" != "true" ]]; then
  to_json "BLT0" "" "Bluetooth désactivé"
  exit 0
fi

CONNECTED_COUNT=0
while read -r dev_path; do
  [[ -z "$dev_path" ]] && continue
  CONN=$(busctl get-property org.bluez "$dev_path" org.bluez.Device1 Connected 2>/dev/null | awk '{print $2}')
  [[ "$CONN" == "true" ]] && CONNECTED_COUNT=$((CONNECTED_COUNT + 1))
done < <(busctl tree org.bluez 2>/dev/null | grep -oP "${ADAPTER}/dev_\S+")

if [[ "$CONNECTED_COUNT" -gt 0 ]]; then
  to_json "BLT1" "" "Bluetooth actif, connecté (${CONNECTED_COUNT})"
else
  to_json "BLT1" "blt-no-device" "Bluetooth actif, aucun appareil connecté"
fi
