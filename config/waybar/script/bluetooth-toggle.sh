#!/run/current-system/sw/bin/bash
POWERED=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [[ "$POWERED" == "yes" ]]; then
  rfkill block bluetooth
else
  rfkill unblock bluetooth
fi
