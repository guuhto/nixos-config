# NixOS Configuration

Because reinstalling Arch for the 10th time got old.

## Structure

```
nixos/
├── flake.nix                  # Inputs and structure
├── configuration.nix          # System entry point
├── hardware-configuration.nix # Machine-specific hardware
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
│   ├── zed/                   # Zed editor config (declarative)
│   │   ├── default.nix
│   │   ├── keymap.nix
│   │   ├── tasks.nix
│   │   └── theme.nix
│   └── zsh.nix
└── config/                    # Dotfiles and vendored assets
    ├── p10k.zsh
    ├── fastfetch/
    ├── kitty/
    ├── nnn/
    │   ├── bookmarks/
    │   └── plugins/
    ├── spotatui/
    │   └── config.yml
    └── plasma/
        ├── appletsrc.backup   # Panel layout (restored manually)
        ├── assets/            # Launcher button icon
        ├── color-schemes/
        ├── cursors/
        ├── desktoptheme/
        ├── icons/
        ├── plasmoids/         # Third-party widgets
        └── wallpapers/        # Video wallpaper plugin
```

## Installation on a new machine

Expect a few hours: the first build pulls ~19 GB and compiles megasync
from source (no binary cache), which alone takes close to an hour.

### 1. Install NixOS, then get git

Git is not included in a fresh install:

```bash
nix-shell -p git
git clone https://github.com/guuhto/nixos-config ~/nixos
```

### 2. Replace hardware-configuration.nix with the new machine's

```bash
sudo nixos-generate-config --show-hardware-config > ~/nixos/hardware-configuration.nix
```

Requires UEFI — `boot.nix` uses systemd-boot with an ESP at `/boot`.

### 3. Apply the configuration

```bash
cd ~/nixos
sudo nixos-rebuild switch --flake .#gustavo-nixos
```

**The installer user is removed during this step.** The `gustavo` user is
created with `initialPassword` set in `modules/users.nix` — change it right
after first login:

```bash
passwd
```

### 4. Restore the panel layout

Panels are not declarative. Copy the backup before logging into Plasma:

```bash
cp ~/nixos/config/plasma/appletsrc.backup \
   ~/.config/plasma-org.kde.plasma.desktop-appletsrc
```

Themes, icons, cursors and third-party widgets are vendored in
`config/plasma/` and apply automatically.

### 5. Authenticate spotifyd

```bash
spotifyd authenticate
```

Fill `config/spotatui/client.yml` with the client ID and secret from
https://developer.spotify.com/dashboard — gitignored, not versioned.

**Reauthentication every 6 months:** since July 2026 Spotify expires refresh
tokens 6 months after the original authorization; refreshing the access token
does not extend it. When spotatui stops working, likely without a clear error
message, run `spotifyd authenticate` again. The `client.yml` does not expire.

### 6. Sync MEGA for wallpapers

Both wallpapers live in `~/MEGA/` and are not in this repo — the static one
is a PNG, the live one a 1440p MP4. Until MEGA is synced, the desktop
falls back to a plain background.

## Known manual steps

| What | Why |
|---|---|
| Panel layout | `appletsrc.backup`, copied by hand |
| Spotify OAuth | Token expires every 6 months |
| Wallpapers | Live in MEGA, too large to vendor |
| `virsh net-start default` | libvirt's default network isn't auto-started |

## Updating configuration

New files must be staged before rebuilding — flakes only see tracked paths:

```bash
cd ~/nixos
git add .
sudo nixos-rebuild switch --flake .#gustavo-nixos
git commit -m "describe your change"
git push
```

After changing panels through the GUI, refresh the backup:

```bash
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc \
   ~/nixos/config/plasma/appletsrc.backup
```

## Updating packages

```bash
cd ~/nixos
nix flake update
sudo nixos-rebuild switch --flake .#gustavo-nixos
```
