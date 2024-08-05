#!/bin/bash

chosen=$(echo -e "⏻ Éteindre\n Redémarrer\n Verrouiller" | wofi --dmenu --prompt "Effectuer une action" --style ~/.dotfiles/scripts/power_menu/power_menu.css --width 800 --height 135)

case "$chosen" in
"⏻ Éteindre")
  systemctl poweroff
  ;;
" Redémarrer")
  systemctl reboot
  ;;
" Verrouiller")
  hyprlock
  ;;
*) ;;
esac
