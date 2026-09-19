#!/run/current-system/sw/bin/bash

declare -A COMMANDS=(
  ["shutdown"]="systemctl poweroff"
  ["reboot"]="systemctl reboot"
  ["lock"]="hyprlock"
  ["suspend"]="systemctl suspend"
  ["disconnect"]="hyprctl dispatch exit"
  ["screenshot"]="grim -g \"\$(slurp)\" ~/Pictures/screenshot-\$(date +%s).png"
)

ORDER=(
  "Shutdown"
  "Reboot"
  "Lock"
  "Suspend"
  "Disconnect"
  "Screenshot"
)

MENU=$(printf '%s\n' "${ORDER[@]}")

hyprctl keyword gestures:workspace_swipe false
trap 'hyprctl keyword gestures:workspace_swipe true' EXIT

chosen=$(echo -e "$MENU" |
  rofi -dmenu -i -theme ~/.dotfiles/config/rofi/programs/config.rasi -p "EXEC")

chosen_lower=$(echo "$chosen" | tr '[:upper:]' '[:lower:]')

[[ -n "$chosen_lower" ]] && eval "${COMMANDS[$chosen_lower]}"
