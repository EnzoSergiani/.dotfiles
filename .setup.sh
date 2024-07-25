#!/bin/bash

set -e

# name of packages to install
PACKAGES=(  
    "alacritty"
    "alsa-utils"
    "base"
    "base-devel"
    "blueberry"
    "bluez-utils"
    "bluez"
    "brightnessctl"
    "code"
    "discord"
    "dunst"
    "efibootmgr"
    "eog"
    "firefox"
    "git"
    "gnome-calculator"
    "gnome-disk-utility"
    "gnome-font-viewer"
    "gnome-system-monitor"
    "grub"
    "hyprland"
    "hyprlock"
    "hyprpaper"
    "iwd"
    "man-db"
    "nautilus"
    "neofetch"
    "neovim"
    "neotwork-manager-applet"
    "networkmanager"
    "npm"
    "pavucontrol"
    "pipewire"
    "pipewire-alsa"
    "pipewire-audio"
    "pipewire-jack"
    "pipewire-pulse"
    "ripgrep"
    "signal-desktop"
    "unzip"
    "virtualbox"
    "vlc"
    "waybar"
    "wget"
    "wireplumber"
    "wmctrl"
    "wofi"
    "xdg-user-dirs"
)

# update system
sudo pacman -Syu --noconfirm

# installation of packages
for package in "${PACKAGES[@]}"; do
    sudo pacman -S --needed --noconfirm "$packages"
done

# yay
if git clone https://aur.archlinux.org/yay.git /opt/; then
  cd yay
  makepkg -si
else
  echo "Failed to clone yay repository."
  exit 1
if

# bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc

# Nvim
rm -rf ~/.config/nvim
if git clone https://github.com/NvChad/starter ~/.config/nvim; then
    ln -sf ~/.dotfiles/nvim/chadrc.lua ~/.config/nvim/lua/chadrc.lua
    ln -sf ~/.dotfiles/nvim/mappings.lua ~/.config/nvim/lua/mappings.lua
    ln -sf ~/.dotfiles/nvim/options.lua ~/.config/nvim/lua/options.lua
    ln -sf ~/.dotfiles/nvim/init.lua ~/.config/nvim/lua/plugin/init.lua
else
    echo "Failed to clone NvChad repository."
    exit 1
fi

# alacritty
mkdir -p ~/.config/alacritty 
ln -sf ~/.dotfiles/alacritty/alacritty.toml ~/.config/alacritty/

# dunst
mkdir -p ~/.config/dunst 
ln -sf ~/.dotfiles/dunst/dunstrc ~/.config/dunst/

# hypr
mkdir -p ~/.config/hypr
ln -sf ~/.dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/.dotfiles/hypr/hyprpaper.conf ~/.config/hypr/

# waybar
ln -sf ~/.dotfiles/waybar/config.jsonc ~/.config/waybar/ 
ln -sf ~/.dotfiles/waybar/style.css ~/.config/waybar/

# wofi
mkdir -p ~/.config/wofi 
ln -sf ~/.dotfiles/wofi/style.css ~/.config/wofi/ 
ln -sf ~/.dotfiles/wofi/config ~/.config/wofi/

echo "Installation and configuration done."

