#!/run/current-system/sw/bin/bash

shutdown="  Éteindre"
reboot="  Redémarrer"
lock="  Verrouiller"

chosen=$(echo -e "$shutdown\n$reboot\n$lock" |
  rofi -dmenu -theme ~/.dotfiles/config/rofi/themes/power-theme.rasi -p "POWER")

case $chosen in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  hyprlock
  ;;
esac
