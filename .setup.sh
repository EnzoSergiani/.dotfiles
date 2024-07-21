#!/bin/bash

# name of packages to install
PACKAGES=(
    "hyprland"
    "firefox"
    "alacritty"
    "neovim"
    "rofi"
)

# update
sudo pacman -Syu

# installation of packages
for package in "${PACKAGES[@]}"; do
    sudo pacman -S --noconfirm $package
done

# bashrc
ln -sf ~/dotfiles/.bashrc ~/.bashrc
sudo source ~/.bashrc

# nvim
git clone https://github.com/NvChad/starter ~/.config/nvim
ln -sf ~/dotfiles/nvim/chadrc.lua ~/.config/nvim/lua
ln -sf ~/dotfiles/nvim/mappings.lua ~/.config/nvim/lua
ln -sf ~/dotfiles/nvim/options.lua ~/.config/nvim/lua
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/lua/plugin

# hyprland
ln -sf ~/dotfiles/hypr/hyprland.conf ~/.config/hypr/

echo "Installation and configuration done."
