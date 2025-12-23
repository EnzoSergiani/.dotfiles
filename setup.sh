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

if [ "$CURRENT_DIR" != "$DOTFILES" ]; then
  echo "This script must be executed from:"
  echo "  $DOTFILES"
  echo "Current directory:"
  echo "  $CURRENT_DIR"
  exit 1
fi

echo "Updating dotfiles repository..."
git pull --rebase

echo "Linking NixOS configuration..."

if [ ! -f "$NEW_CONFIG" ]; then
  echo "Error: $NEW_CONFIG not found."
  exit 1
fi

if [ -e "$CONFIG_FILE" ] || [ -L "$CONFIG_FILE" ]; then
  rm -f "$CONFIG_FILE"
fi

ln -s "$NEW_CONFIG" "$CONFIG_FILE"

echo "NixOS configuration linked."

echo "Configuring Home Manager channel..."

if nix-channel --list | grep -q "home-manager"; then
  nix-channel --remove home-manager
fi

nix-channel --add "$HM_URL" home-manager
nix-channel --update

echo "Home Manager configured."

echo "Setup completed. You can now run:"
echo "  sudo nixos-rebuild switch"
