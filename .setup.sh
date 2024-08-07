#!/bin/bash

set -e

# name of packages to install
PACKAGES=(
  "alsa-utils"
  "baobab"
  "base"
  "base-devel"
  "blueberry"
  "bluez-utils"
  "bluez"
  "brightnessctl"
  "discord"
  "dmd"
  "dmd-docs"
  "dunst"
  "efibootmgr"
  "eog"
  "fastfetch"
  "firefox"
  "fprintd"
  "gimp"
  "git"
  "gnome-calculator"
  "gnome-disk-utility"
  "gnome-font-viewer"
  "gnome-system-monitor"
  "gnome-text-editor"
  "grub"
  "htop"
  "hyprland"
  "hyprlock"
  "hyprpaper"
  "inkscape"
  "iwd"
  "kitty"
  "man-db"
  "nautilus"
  "neofetch"
  "neovim"
  "network-manager-applet"
  "networkmanager"
  "npm"
  "pavucontrol"
  "pipewire"
  "pipewire-alsa"
  "pipewire-audio"
  "pipewire-jack"
  "pipewire-pulse"
  "psensor",
  "ripgrep"
  "signal-desktop"
  "stow"
  "tree-sitter"
  "tree-sitter-cli"
  "unzip"
  "virtualbox"
  "vlc"
  "waybar"
  "wget"
  "wireplumber"
  "wl-clipboard",
  "wmctrl"
  "wofi"
  "xdg-user-dirs"
)

# update system
sudo pacman -Syu --noconfirm

# installation of packages
for package in "${PACKAGES[@]}"; do
  sudo pacman -S --needed --noconfirm "$package"
done

# yay
#if git clone https://aur.archlinux.org/yay.git /opt/; then
#  cd yay
#  makepkg -si
#else
#  echo "Failed to clone yay repository."
#  exit 1
#fi

# bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc

# Nvim
rm -rf ~/.config/nvim && rm -rf ~/.cache/nvim

if git clone https://github.com/NvChad/starter ~/.config/nvim; then
  echo "NvChad repository successfully cloned."
else
  echo "Failed to clone NvChad repository."
  exit 1
fi

mkdir -p ~/.config/{dunst,fastfetch,hypr,kitty,nvim/scripts,power_menu,waybar,wofi}

ln -sf ~/.dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

ln -sf ~/.dotfiles/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

ln -sf ~/.dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/.dotfiles/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -sf ~/.dotfiles/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf

ln -sf ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

ln -sf ~/.dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/.dotfiles/nvim/lua/chadrc.lua ~/.config/nvim/lua/chadrc.lua
ln -sf ~/.dotfiles/nvim/lua/options.lua ~/.config/nvim/lua/options.lua
ln -sf ~/.dotfiles/nvim/lua/mappings.lua ~/.config/nvim/lua/mappings.lua
ln -sf ~/.dotfiles/nvim/lua/plugins/init.lua ~/.config/nvim/lua/plugins/init.lua
ln -sf ~/.dotfiles/nvim/lua/configs/lazy.lua ~/.config/nvim/lua/configs/lazy.lua
ln -sf ~/.dotfiles/nvim/lua/configs/conform.lua ~/.config/nvim/lua/configs/conform.lua
ln -sf ~/.dotfiles/nvim/lua/configs/lspconfig.lua ~/.config/nvim/lua/configs/lspconfig.lua

ln -sf ~/.dotfiles/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/.dotfiles/waybar/style.css ~/.config/waybar/style.css

ln -sf ~/.dotfiles/wofi/config ~/.config/wofi/config
ln -sf ~/.dotfiles/wofi/style.css ~/.config/wofi/style.css

echo "Installation and configuration done."
