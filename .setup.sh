#!/bin/bash

set -e

# name of packages to install
PACKAGES=(
    "unzip"
    "tar"
    "man-db"
    "vlc"
    "hyprland"
    "firefox"
    "alacritty"
    "nautilus"
    "neovim"
    "wofi"
    "python"
    "nodejs"
    "npm"
    "openssh"
    "gnome-disk-utility"
    "parted"
)

# update
sudo pacman -Syu

# installation of packages
for package in "${PACKAGES[@]}"; do
    sudo pacman -S --needed --noconfirm $package
done

# bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
source ~/.bashrc

# nvim
rm -rf ~/.config/nvim
git clone https://github.com/NvChad/starter ~/.config/nvim
ln -sf ~/.dotfiles/nvim/chadrc.lua ~/.config/nvim/lua/chadrc.lua
ln -sf ~/.dotfiles/nvim/mappings.lua ~/.config/nvim/lua/mappings.lua
ln -sf ~/.dotfiles/nvim/options.lua ~/.config/nvim/lua/options.lua
ln -sf ~/.dotfiles/nvim/init.lua ~/.config/nvim/lua/plugin/init.lua

# hyprland
mkdir -p ~/.config/hypr
ln -sf ~/.dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

# wofi
mkdir -p ~/.config/wofi
ln -sf ~/.dotfiles/wofi/style.css ~/.config/wofi/
ln -sf ~/.dotfiles/wofi/config ~/.config/wofi/

echo "Installation and configuration done."

