#!/run/current-system/sw/bin/bash

WALL_DIR="$HOME/.dotfiles/wallpapers"
CACHE_DIR="$HOME/.cache/rofi-wallpaper"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

mkdir -p "${CACHE_DIR}"

shopt -s nullglob
for imagen in "$WALL_DIR"/*.jpg "$WALL_DIR"/*.jpeg "$WALL_DIR"/*.png "$WALL_DIR"/*.webp; do
    if [ -f "$imagen" ]; then
        nombre_archivo=$(basename "$imagen")
        if [ ! -f "${CACHE_DIR}/${nombre_archivo}" ]; then
            magick "$imagen" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${CACHE_DIR}/${nombre_archivo}" 2>/dev/null
        fi
    fi
done
shopt -u nullglob

wall_selection=$(
    shopt -s nullglob
    for imagen in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
        if [ -f "$imagen" ]; then
            nombre_archivo=$(basename "$imagen")
            nombre_sin_extension="${nombre_archivo%.*}"
            echo -en "$nombre_archivo\x00icon\x1f${CACHE_DIR}/$nombre_archivo\n"
        fi
    done | sort | rofi -dmenu -theme ~/.dotfiles/config/rofi/wallpaper-theme.rasi -p "WALLPAPER"
    shopt -u nullglob
)

if [[ -n "$wall_selection" ]]; then
    WALLPAPER_PATH="${WALL_DIR}/${wall_selection}"

    hyprctl hyprpaper preload "$WALLPAPER_PATH"
    hyprctl hyprpaper wallpaper ",$WALLPAPER_PATH"
    hyprctl hyprpaper unload unused

    cat > "$HYPRPAPER_CONF" << EOF
preload = $WALLPAPER_PATH
wallpaper = ,$WALLPAPER_PATH
splash = false
ipc = on
EOF
fi

exit 0
