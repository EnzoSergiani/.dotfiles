#!/run/current-system/sw/bin/bash

selected=$(cliphist list | rofi \
  -dmenu \
  -p "CLIPBOARD" \
  -theme ~/.dotfiles/config/rofi/themes/clipboard-theme.rasi \
  -display-columns 2)

[ -z "$selected" ] && exit 0

echo "$selected" | cliphist decode | wl-copy
