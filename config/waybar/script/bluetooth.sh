#!/run/current-system/sw/bin/bash

POWERED=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$POWERED" != "yes" ]]; then
  printf '{"text":"󰂲 󰝦","tooltip":"Bluetooth off","class":"off"}\n'
  exit 0
fi

CONNECTED=$(bluetoothctl devices Connected | head -n1)

if [[ -z "$CONNECTED" ]]; then
  printf '{"text":" 󰝦","tooltip":"No device connected","class":"disconnected"}\n'
else
  NAME=$(echo "$CONNECTED" | cut -d' ' -f3-)
  MAC=$(echo "$CONNECTED" | awk '{print $2}')
  BATTERY=$(bluetoothctl info "$MAC" | grep "Battery Percentage" | awk '{print $4}' | tr -d '()')

  if [[ -n "$BATTERY" ]]; then
    TOOLTIP="$NAME - $BATTERY%"
  else
    TOOLTIP="$NAME"
  fi

  printf '{"text":" 󰪥","tooltip":"%s","class":"connected"}\n' "$TOOLTIP"
fi
