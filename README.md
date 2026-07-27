# Dotfiles

My full NixOS system configuration, Home Manager setup, and user configuration files for my desktop environment and applications.

## Requirements

- NixOS 24.05 or later
- UEFI/GPT partitioning (systemd-boot)
- git available

> Flakes are enabled by default by the NixOS graphical installer since 24.05.
> This configuration targets NixOS only — standalone Nix (non-NixOS) is not supported.

## Installation

```bash
git clone https://github.com/EnzoSergiani/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup.sh
```

The script will:

1. Verify prerequisites (NixOS, git, flakes, UEFI)
2. Check or generate `/etc/nixos/hardware-configuration.nix`
3. Link `/etc/nixos/configuration.nix` to the dotfiles
4. Create symlinks from `config/` to `~/.config/`
5. Run `nixos-rebuild switch --impure --flake .#bespin`
6. Restore any symlinks overwritten by Home Manager

## Structure

```
.
├── config/          # User configs symlinked to ~/.config/
├── latex/           # LaTeX templates and configs
├── nixos/
│   ├── flake.nix
│   ├── configuration.nix
│   ├── dousai.nix
│   └── home/        # Home Manager modules
├── README.md:
├── setup.sh         # Bootstrap script
└── wallpaper/       # Wallpapers
```

## Notes

- `hardware-configuration.nix` is machine-specific and lives in `/etc/nixos/` — it is not tracked in this repository
- `--impure` is required because `configuration.nix` imports `/etc/nixos/hardware-configuration.nix` from outside the flake
- Hostname is hardcoded as `bespin` in `setup.sh` — update it for a different machine
