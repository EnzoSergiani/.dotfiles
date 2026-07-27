#!/usr/bin/env bash

# =============================================================================
# Bootstrap NixOS + dotfiles (bespin)
# Requirements : nix installed, git available, internet connection
# Usage        : bash setup.sh
# =============================================================================

set -euo pipefail

# ── Colors ────────────────────────────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
die() {
  echo -e "${RED}[ERR]${NC}   $*" >&2
  exit 1
}

# ── Variables ─────────────────────────────────────────────────────────────────

DOTFILES_REPO="https://github.com/EnzoSergiani/.dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DST="$HOME/.config"
NIXOS_DIR="/etc/nixos"
HOSTNAME="bespin"

# ── Initial checks ────────────────────────────────────────────────────────────

echo ""
echo "=============================================="
echo "  NixOS Bootstrap — dotfiles installer"
echo "=============================================="
echo ""

if [ "$EUID" -eq 0 ]; then
  die "Do not run this script as root. Run it as a normal user."
fi

if ! command -v nix &>/dev/null; then
  die "Nix is not installed on this system."
fi

if ! command -v git &>/dev/null; then
  die "git is not available. Install it with: nix-env -iA nixpkgs.git"
fi

# ── Flakes check ──────────────────────────────────────────────────────────────

if ! nix flake --version &>/dev/null 2>&1; then
  die "Flakes are not enabled.\nThis is unexpected on NixOS 24.05+.\nAdd to configuration.nix:\n  nix.settings.experimental-features = [ \"nix-command\" \"flakes\" ];\nThen run: sudo nixos-rebuild switch"
fi

# ── UEFI check ────────────────────────────────────────────────────────────────

if [ ! -d /sys/firmware/efi ]; then
  die "This system booted in BIOS/Legacy mode.\nconfiguration.nix uses systemd-boot which requires UEFI.\nRe-install NixOS with a UEFI/GPT partition layout."
fi

success "All prerequisites satisfied"

# ── Clone dotfiles ────────────────────────────────────────────────────────────

echo ""
info "Cloning dotfiles..."

if [ -d "$DOTFILES_DIR" ]; then
  warn "$DOTFILES_DIR already exists — updating via git pull"
  git -C "$DOTFILES_DIR" pull
else
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

success "Dotfiles available at $DOTFILES_DIR"

# ── Check hardware-configuration.nix ─────────────────────────────────────────

echo ""
info "Checking hardware-configuration.nix..."

HW_SRC="$NIXOS_DIR/hardware-configuration.nix"

if [ ! -f "$HW_SRC" ]; then
  info "Generating via nixos-generate-config (sudo required)..."
  sudo nixos-generate-config
fi

if [ ! -f "$HW_SRC" ]; then
  die "hardware-configuration.nix not found in $NIXOS_DIR."
fi

success "hardware-configuration.nix found in $NIXOS_DIR"

# ── Link NixOS configuration ──────────────────────────────────────────────────

echo ""
info "Linking configuration.nix into /etc/nixos/ ..."

CONFIG_FILE="$NIXOS_DIR/configuration.nix"
NEW_CONFIG="$DOTFILES_DIR/nixos/configuration.nix"

if [ ! -f "$NEW_CONFIG" ]; then
  die "$NEW_CONFIG not found in dotfiles."
fi

if [ -f "$CONFIG_FILE" ] && [ ! -L "$CONFIG_FILE" ]; then
  sudo cp "$CONFIG_FILE" "$CONFIG_FILE.backup"
  warn "Backup created: $CONFIG_FILE.backup"
fi

sudo rm -f "$CONFIG_FILE"
sudo ln -s "$NEW_CONFIG" "$CONFIG_FILE"
success "configuration.nix linked"

# ── Symlinks ~/.config ────────────────────────────────────────────────────────

echo ""
info "Creating symlinks config/ -> ~/.config/ ..."

mkdir -p "$CONFIG_DST"

for item in "$CONFIG_SRC"/*; do
  [ -e "$item" ] || continue

  item_name=$(basename "$item")
  [ -n "$item_name" ] || continue

  src_path="$item"
  dst_path="$CONFIG_DST/$item_name"

  [ -n "$dst_path" ] || continue

  if [ -e "$dst_path" ] && [ ! -L "$dst_path" ]; then
    cp -r "$dst_path" "$dst_path.backup"
    warn "Backup: $dst_path.backup"
  fi

  rm -rf "$dst_path"
  ln -s "$src_path" "$dst_path"
  echo "    ✓ config/$item_name -> ~/.config/$item_name"
done

success "Symlinks created"

# ── NixOS rebuild ─────────────────────────────────────────────────────────────

echo ""
info "Rebuilding NixOS via Flake (hostname: $HOSTNAME)..."

sudo nixos-rebuild switch --impure --flake "$DOTFILES_DIR/nixos#$HOSTNAME"

# ── Restore symlinks after rebuild ───────────────────────────────────────────

echo ""
info "Verifying symlinks after rebuild..."

for item in "$CONFIG_SRC"/*; do
  [ -e "$item" ] || continue

  item_name=$(basename "$item")
  [ -n "$item_name" ] || continue

  src_path="$item"
  dst_path="$CONFIG_DST/$item_name"

  if [ -L "$dst_path" ]; then
    link_target=$(readlink "$dst_path")
    if [[ "$link_target" == /nix/store/* ]]; then
      warn "nix/store link detected on $item_name — restoring manual symlink"
      rm -f "$dst_path"
      ln -s "$src_path" "$dst_path"
      echo "    ✓ Restored: config/$item_name -> ~/.config/$item_name"
    fi
  fi
done

success "Symlinks verified"

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo "=============================================="
echo "  Setup completed successfully!"
echo "=============================================="
echo ""
echo "  Dotfiles : $DOTFILES_DIR"
echo "  Config   : $CONFIG_DST (symlinks to dotfiles)"
echo "  NixOS    : /etc/nixos/configuration.nix -> $NEW_CONFIG"
echo ""
echo "  Changes in ~/.dotfiles/config/ take effect immediately."
echo ""
