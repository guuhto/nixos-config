# NixOS Configuration
Because reinstalling Arch for the 10th time got old.

## Structure
```
nixos/
├── flake.nix                  # Inputs and structure
├── configuration.nix          # System entry point
├── hardware-configuration.nix # Machine-specific hardware
├── modules/                   # System modules
│   ├── boot.nix
│   ├── network.nix
│   ├── desktop.nix
│   ├── audio.nix
│   ├── bluetooth.nix
│   ├── flatpak.nix
│   ├── programs.nix
│   ├── fonts.nix
│   └── users.nix
├── home/                      # User configuration (Home Manager)
│   ├── default.nix
│   ├── packages.nix
│   ├── zsh.nix
│   ├── variables.nix
│   ├── plasma.nix
│   ├── git.nix
│   └── dotfiles.nix
└── config/                    # App dotfiles
├── fastfetch/
├── kitty/
├── zed/
├── spotatui/
└── nnn/
```
## Installation on a new machine

### 1. Install NixOS normally and clone the repository

```bash
git clone https://github.com/guuhto/nixos-config ~/nixos
```

### 2. Replace hardware-configuration.nix with the new machine's

```bash
sudo nixos-generate-config --show-hardware-config > ~/nixos/hardware-configuration.nix
```

### 3. Apply the configuration

```bash
cd ~/nixos
sudo nixos-rebuild switch --flake .#gustavo-nixos
```

### 4. Install third-party themes manually via KDE Store

- Sweet-Ambar-Blue (Plasma color scheme and style)
- Sweet-Dark-Transparent (window decoration)
- GreyStone-circle (icons)
- Future-dark Cursors (cursors)

### 5. Set up Rust toolchain

```bash
rustup default stable
```

## Updating configuration

```bash
cd ~/nixos
sudo nixos-rebuild switch --flake .#gustavo-nixos
git add .
git commit -m "describe your change"
git push
```

## Updating packages

```bash
cd ~/nixos
nix flake update
sudo nixos-rebuild switch --flake .#gustavo-nixos
```
