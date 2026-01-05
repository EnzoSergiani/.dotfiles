#!/run/current-system/sw/bin/bash

# Fonction pour le menu WiFi
show_wifi_menu() {
  notify-send "Scan des réseaux Wi-Fi..."

  # Obtenir la liste des réseaux WiFi
  wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

  # Vérifier l'état du WiFi
  connected=$(nmcli -fields WIFI g)
  if [[ "$connected" =~ "enabled" ]]; then
    toggle="󰖪  Désactiver Wi-Fi"
  elif [[ "$connected" =~ "disabled" ]]; then
    toggle="󰖩  Activer Wi-Fi"
  fi

  # Menu avec rofi
  chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -theme ~/.dotfiles/config/rofi/themes/network-theme.rasi -p "WIFI")

  # Récupérer le nom du réseau
  read -r chosen_id <<<"${chosen_network:3}"

  if [ "$chosen_network" = "" ]; then
    return
  elif [ "$chosen_network" = "󰖩  Activer Wi-Fi" ]; then
    nmcli radio wifi on
    notify-send "Wi-Fi activé"
  elif [ "$chosen_network" = "󰖪  Désactiver Wi-Fi" ]; then
    nmcli radio wifi off
    notify-send "Wi-Fi désactivé"
  else
    success_message="Connexion établie à \"$chosen_id\""

    # Vérifier si la connexion est déjà enregistrée
    saved_connections=$(nmcli -g NAME connection)
    if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
      nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Wi-Fi" "$success_message"
    else
      if [[ "$chosen_network" =~ "" ]]; then
        wifi_password=$(rofi -dmenu -password -theme ~/.dotfiles/config/rofi/themes/network-theme.rasi -p "Mot de passe")
      fi
      nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Wi-Fi" "$success_message"
    fi
  fi
}

# Fonction pour le menu Bluetooth
show_bluetooth_menu() {
  # Vérifier l'état du Bluetooth
  bt_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

  if [[ "$bt_status" = "yes" ]]; then
    toggle="󰂲  Désactiver Bluetooth"
  else
    toggle="󰂯  Activer Bluetooth"
  fi

  scan_option="  Scanner appareils"

  # Construire la liste des appareils
  menu="$toggle\n"

  if [[ "$bt_status" = "yes" ]]; then
    menu="$menu$scan_option\n"

    # Lister les appareils appairés
    while IFS= read -r line; do
      mac=$(echo "$line" | awk '{print $2}')
      name=$(echo "$line" | cut -d' ' -f3-)

      # Vérifier si l'appareil est connecté
      if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
        menu="$menu󰂱  $name [connecté]\n"
      else
        menu="$menu󰂯  $name\n"
      fi
    done < <(bluetoothctl devices 2>/dev/null)
  fi

  # Afficher le menu
  chosen=$(echo -e "$menu" | rofi -dmenu -i -theme ~/.dotfiles/config/rofi/themes/network-theme.rasi -p "BLUETOOTH")

  if [ "$chosen" = "" ]; then
    return
  elif [ "$chosen" = "󰂯  Activer Bluetooth" ]; then
    bluetoothctl power on
    notify-send "Bluetooth activé"
  elif [ "$chosen" = "󰂲  Désactiver Bluetooth" ]; then
    bluetoothctl power off
    notify-send "Bluetooth désactivé"
  elif [ "$chosen" = "  Scanner appareils" ]; then
    notify-send "Scan Bluetooth" "Recherche d'appareils..."
    timeout 10 bluetoothctl scan on &
    sleep 10
    bluetoothctl scan off
    notify-send "Scan terminé"
    show_bluetooth_menu
  else
    # Extraire le nom de l'appareil
    device_name=$(echo "$chosen" | sed 's/^[^ ]* *//' | sed 's/ *\[.*\]//' | xargs)
    mac=$(bluetoothctl devices 2>/dev/null | grep "$device_name" | awk '{print $2}')

    if [ -n "$mac" ]; then
      if echo "$chosen" | grep -q "\[connecté\]"; then
        bluetoothctl disconnect "$mac"
        notify-send "Bluetooth" "Déconnecté de $device_name"
      else
        notify-send "Bluetooth" "Connexion à $device_name..."
        if bluetoothctl connect "$mac" 2>&1 | grep -q "successful"; then
          notify-send "Bluetooth" "Connecté à $device_name"
        else
          notify-send "Bluetooth" "Échec de connexion à $device_name"
        fi
      fi
    fi
  fi
}

# Menu principal
main_menu() {
  wifi_option="󰖩  Wi-Fi"
  bt_option="󰂯  Bluetooth"

  chosen=$(echo -e "$wifi_option\n$bt_option" | rofi -dmenu -i -theme ~/.dotfiles/config/rofi/themes/network-theme.rasi -p "NETWORK")

  case "$chosen" in
  *"Wi-Fi"*)
    show_wifi_menu
    ;;
  *"Bluetooth"*)
    show_bluetooth_menu
    ;;
  *)
    exit 0
    ;;
  esac
}

# Lancer le menu principal
main_menu
