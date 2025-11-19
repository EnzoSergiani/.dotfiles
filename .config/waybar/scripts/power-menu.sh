#!/bin/bash

choice=$(printf "  Éteindre\n  Redémarrer\n  Veille\n  Annuler" | rofi -dmenu -i -p "Système")

case "$choice" in
  "  Éteindre") systemctl poweroff ;;
  "  Redémarrer") systemctl reboot ;;
  "  Veille") systemctl suspend ;;
  *) exit 0 ;;
esac
