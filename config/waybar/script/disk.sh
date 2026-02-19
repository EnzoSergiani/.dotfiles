#!/run/current-system/sw/bin/bash
ICONS=("󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥")
STATS=$(df -h / | awk 'NR==2 {print $3, $2, $5}')
USED=$(echo "$STATS" | awk '{print $1}')
TOTAL=$(echo "$STATS" | awk '{print $2}')
PCT=$(echo "$STATS" | awk '{print int($3)}')
INDEX=$((PCT * 8 / 100))
[[ $INDEX -gt 8 ]] && INDEX=8

echo "{\"text\":\"${ICONS[$INDEX]}\",\"tooltip\":\"$USED / $TOTAL ($PCT%)\"}"
