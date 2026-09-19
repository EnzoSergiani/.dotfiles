#!/run/current-system/sw/bin/bash

WALL_DIR="$HOME/.dotfiles/wallpapers"
CACHE_DIR="$HOME/.cache/rofi-wallpaper"
CURRENT_WALL_LINK="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE_DIR"

hyprctl keyword gestures:workspace_swipe false
trap 'hyprctl keyword gestures:workspace_swipe true' EXIT

shopt -s nullglob
for imagen in "$WALL_DIR"/*.jpg "$WALL_DIR"/*.jpeg "$WALL_DIR"/*.png "$WALL_DIR"/*.webp; do
  nombre_archivo=$(basename "$imagen")
  [[ -f "${CACHE_DIR}/${nombre_archivo}" ]] ||
    magick "$imagen" -strip -thumbnail 420x420^ -gravity center -extent 420x420 -quality 85 "${CACHE_DIR}/${nombre_archivo}" 2>/dev/null
done
shopt -u nullglob

wall_selection=$(
  shopt -s nullglob
  for imagen in "$WALL_DIR"/*.jpg "$WALL_DIR"/*.jpeg "$WALL_DIR"/*.png "$WALL_DIR"/*.webp; do
    nombre_archivo=$(basename "$imagen")
    echo -en "${nombre_archivo}\x00icon\x1f${CACHE_DIR}/${nombre_archivo}\n"
  done | sort | rofi -dmenu -theme ~/.dotfiles/config/rofi/wallpapers/config.rasi -p "WALLPAPER"
  shopt -u nullglob
)

if [[ -n "$wall_selection" ]]; then
  WALLPAPER_PATH="${WALL_DIR}/${wall_selection}"
  ln -sf "$WALLPAPER_PATH" "$CURRENT_WALL_LINK"
  while read -r mon; do
    hyprctl hyprpaper wallpaper "${mon},${WALLPAPER_PATH}" >/dev/null 2>&1
  done < <(hyprctl monitors -j | jq -r '.[].name')
fi

exit 0
