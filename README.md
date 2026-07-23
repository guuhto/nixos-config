# NixOS Configuration
Because reinstalling Arch for the 10th time got old.

## Structure
```
nixos/
├── flake.nix                  # Inputs and structure
├── configuration.nix          # System entry point
├── hardware-configuration.nix # Machine-specific hardware
├── p10k.zsh                   # Powerlevel10k config
├── modules/                   # System modules
│   ├── audio.nix
│   ├── bluetooth.nix
│   ├── boot.nix
│   ├── desktop.nix
│   ├── flatpak.nix
│   ├── fonts.nix
│   ├── network.nix
│   ├── programs.nix
│   ├── users.nix
│   └── virtualization.nix
├── home/                      # User configuration (Home Manager)
│   ├── default.nix
│   ├── dotfiles.nix
│   ├── git.nix
│   ├── nvim.nix
│   ├── packages.nix
│   ├── plasma.nix
│   ├── rust.nix
│   ├── spotifyd.nix
│   ├── variables.nix
│   ├── zed/
│   │   ├── default.nix
│   │   ├── keymap.nix
│   │   ├── tasks.nix
│   │   └── theme.nix
│   └── zsh.nix
└── config/                    # App dotfiles
    ├── fastfetch/
    ├── kitty/
    ├── nnn/
    │   ├── plugins/
    │   └── bookmarks/
    └── spotatui/
        └── config.yml
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
