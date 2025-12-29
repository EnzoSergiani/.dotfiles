#!/usr/bin/env bash
set -euo pipefail

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo:"
  echo "  sudo ./setup.sh"
  exit 1
fi

if [ -z "${SUDO_USER:-}" ]; then
  echo "Cannot detect the calling user (SUDO_USER is empty)."
  exit 1
fi

DOTFILES="$(eval echo ~$SUDO_USER)/.dotfiles"
CURRENT_DIR="$(pwd)"
NIXOS_DIR="/etc/nixos"
CONFIG_FILE="$NIXOS_DIR/configuration.nix"
NEW_CONFIG="$DOTFILES/nixos/configuration.nix"
HM_URL="https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz"
USER_HOME="$(eval echo ~$SUDO_USER)"
CONFIG_SRC="$DOTFILES/config"
CONFIG_DST="$USER_HOME/.config"

if [ "$CURRENT_DIR" != "$DOTFILES" ]; then
  echo "This script must be executed from:"
  echo "  $DOTFILES"
  echo "Current directory:"
  echo "  $CURRENT_DIR"
  exit 1
fi

echo ""
echo "Cleaning old Home Manager links..."
find "$CONFIG_DST" -type l -lname '/nix/store/*' -delete 2>/dev/null || true

echo ""
echo "Linking NixOS configuration..."
if [ ! -f "$NEW_CONFIG" ]; then
  echo "Error: $NEW_CONFIG not found."
  exit 1
fi

if [ -f "$CONFIG_FILE" ] && [ ! -L "$CONFIG_FILE" ]; then
  echo "Backing up existing configuration to $CONFIG_FILE.backup"
  cp "$CONFIG_FILE" "$CONFIG_FILE.backup"
fi

rm -f "$CONFIG_FILE"
ln -s "$NEW_CONFIG" "$CONFIG_FILE"
echo "✓ NixOS configuration linked"

echo ""
echo "Configuring Home Manager channel..."
sudo -u "$SUDO_USER" bash <<EOF
nix-channel --remove home-manager 2>/dev/null || true
nix-channel --add "$HM_URL" home-manager
nix-channel --update
EOF
echo "✓ Home Manager configured"

echo ""
echo "Linking dotfiles from config/ to ~/.config/ ..."

if [ ! -d "$CONFIG_DST" ]; then
  sudo -u "$SUDO_USER" mkdir -p "$CONFIG_DST"
fi

if [ -d "$CONFIG_SRC" ]; then
  for item in "$CONFIG_SRC"/*; do
    [ -e "$item" ] || continue

    item_name=$(basename "$item")
    src_path="$item"
    dst_path="$CONFIG_DST/$item_name"

    if [ -e "$dst_path" ] && [ ! -L "$dst_path" ]; then
      echo "  Backing up: $dst_path -> $dst_path.backup"
      sudo -u "$SUDO_USER" cp -r "$dst_path" "$dst_path.backup"
    fi

    rm -rf "$dst_path"
    sudo -u "$SUDO_USER" ln -s "$src_path" "$dst_path"
    echo "  ✓ Linked: config/$item_name -> ~/.config/$item_name"
  done
else
  echo "⚠ Warning: $CONFIG_SRC directory not found"
fi

echo ""
echo "Rebuilding NixOS configuration..."
nixos-rebuild switch

echo ""
echo "Verifying and fixing symlinks after Home Manager..."
for item in "$CONFIG_SRC"/*; do
  [ -e "$item" ] || continue

  item_name=$(basename "$item")
  src_path="$item"
  dst_path="$CONFIG_DST/$item_name"

  if [ -L "$dst_path" ]; then
    link_target=$(readlink "$dst_path")
    if [[ "$link_target" == /nix/store/* ]]; then
      echo "  ⚠ Fixing nix store link: $item_name"
      rm -f "$dst_path"
      sudo -u "$SUDO_USER" ln -s "$src_path" "$dst_path"
    fi
  fi
done

echo ""
echo "=========================================="
echo "Setup completed successfully!"
echo "=========================================="
echo ""
echo "All configs from ~/.dotfiles/config/ are now linked to ~/.config/"
echo "Modifications to your dotfiles will take effect immediately."
echo ""
