# NixOS Configuration

Because reinstalling Arch for the 10th time got old.

## Structure

```
nixos/
├── flake.nix                  # Inputs and structure
├── configuration.nix          # System entry point
├── hardware-configuration.nix # Machine-specific hardware
├── .sops.yaml                 # Which age keys can decrypt secrets/
├── secrets/                   # sops-encrypted, safe to commit
│   └── users.yaml             # gustavo's password hash
├── modules/                   # System modules
│   ├── audio.nix
│   ├── bluetooth.nix
│   ├── boot.nix
│   ├── desktop.nix
│   ├── flatpak.nix
│   ├── fonts.nix
│   ├── network.nix
│   ├── programs.nix
│   ├── sops.nix
│   ├── users.nix
│   └── virtualization.nix
├── home/                      # User configuration (Home Manager)
│   ├── autostart.nix
│   ├── default.nix
│   ├── dotfiles.nix
│   ├── git.nix
│   ├── nvim.nix
│   ├── packages.nix
│   ├── plasma.nix
│   ├── rust.nix
│   ├── spotifyd.nix
│   ├── ssh.nix
│   ├── variables.nix
│   ├── xdg.nix
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

## What is not in this repo

Everything here is reproducible except three things, which have to come from
somewhere else:

| Secret | Where it lives | Consequence if missing |
|---|---|---|
| age key | Password manager / USB stick | No password, no login (see step 3) |
| SSH key | Generated per machine, registered on GitHub | Can build, cannot push |
| `client.yml` | Spotify developer dashboard | spotatui cannot authenticate |

## Installation on a new machine

Expect a few hours: the first build pulls ~19 GB and compiles megasync
from source (no binary cache), which alone takes close to an hour.

### 1. Install NixOS, then get git

Git is not included in a fresh install:

```bash
nix-shell -p git
git clone https://github.com/guuhto/nixos-config ~/nixos
```

HTTPS on purpose — there is no SSH key on this machine yet. Step 7 switches
the remote over.

### 2. Replace hardware-configuration.nix with the new machine's

```bash
sudo nixos-generate-config --show-hardware-config > ~/nixos/hardware-configuration.nix
```

Requires UEFI — `boot.nix` uses systemd-boot with an ESP at `/boot`.

### 3. Install the age key

The `gustavo` password lives encrypted in `secrets/users.yaml` and is
decrypted at boot by sops-nix, using an age key that is **not** in this
repository. Without it there is no password, and `users.mutableUsers = false`
means there is no way in. Do this *before* the first rebuild:

```bash
sudo mkdir -p /var/lib/sops-nix
sudo cp /path/to/key.txt /var/lib/sops-nix/key.txt
sudo chmod 600 /var/lib/sops-nix/key.txt
```

Bring `key.txt` on a USB stick from the old machine, or restore the personal
age key from the password manager — `.sops.yaml` lists it as a second
recipient precisely so the secrets survive losing a host.

To verify before committing to a rebuild:

```bash
nix-shell -p sops
sops -d secrets/users.yaml
```

It should print a `$6$…` hash. If it errors, stop and fix the key — do not
rebuild.

### 4. Apply the configuration

```bash
cd ~/nixos
sudo nixos-rebuild switch --flake .#gustavo-nixos
```

**The installer user is removed during this step.** The `gustavo` password
comes from sops — `passwd` has no effect, since `users.mutableUsers` is
false. Confirm the secret was rendered before logging out:

```bash
sudo ls -l /run/secrets-for-users/   # gustavo-password must be there
su - gustavo                         # must accept the password
```

To change the password later, replace the hash in the secret:

```bash
nix-shell -p sops mkpasswd
mkpasswd -m sha-512
sops secrets/users.yaml
```

Then rebuild and test with `su - gustavo` **before** logging out.

### 5. Restore the panel layout

Panels are not declarative. Copy the backup before logging into Plasma:

```bash
cp ~/nixos/config/plasma/appletsrc.backup \
   ~/.config/plasma-org.kde.plasma.desktop-appletsrc
```

Themes, icons, cursors and third-party widgets are vendored in
`config/plasma/` and apply automatically.

### 6. Authenticate spotifyd

```bash
spotifyd authenticate
```

Fill `config/spotatui/client.yml` with the client ID and secret from
https://developer.spotify.com/dashboard — gitignored, not versioned.

**Reauthentication every 6 months:** since July 2026 Spotify expires refresh
tokens 6 months after the original authorization; refreshing the access token
does not extend it. When spotatui stops working, likely without a clear error
message, run `spotifyd authenticate` again. The `client.yml` does not expire.

### 7. Set up the SSH key for pushing

Cloning over HTTPS works read-only. To push, generate a key and register it:

```bash
ssh-keygen -t ed25519 -C "gustavocorsino50@gmail.com"
```

Use a passphrase — `home/ssh.nix` runs an ssh-agent and loads the key on
first use, so it is only asked once per session. Paste the contents of
`~/.ssh/id_ed25519.pub` at https://github.com/settings/keys, then:

```bash
ssh -T git@github.com                # must greet you by username
cd ~/nixos
git remote set-url origin git@github.com:guuhto/nixos-config.git
```

### 8. Sync MEGA for wallpapers

Both wallpapers live in `~/MEGA/` and are not in this repo — the static one
is a PNG, the live one a 1440p MP4. Until MEGA is synced, the desktop
falls back to a plain background.

## Known manual steps

| What | Why |
|---|---|
| age key | Must be at `/var/lib/sops-nix/key.txt` before the first rebuild |
| SSH key | Generated per machine, registered on GitHub by hand |
| Panel layout | `appletsrc.backup`, copied by hand |
| Spotify OAuth | Token expires every 6 months |
| MEGAsync / Nextcloud login | Autostart is declared, but each client needs a one-time sign-in |
| Wallpapers | Live in MEGA, too large to vendor |
| `virsh net-start default` | libvirt's default network isn't auto-started |

## Updating configuration

New files must be staged before rebuilding — flakes only see tracked paths.
**An unstaged edit does not raise an error:** the build succeeds and silently
uses the previous version of the file. If a change appears to have no effect,
check `git status` first.

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

## Working with secrets

`secrets/` is encrypted with sops and safe to commit. Never edit those files
with a plain editor — that overwrites the ciphertext and breaks the MAC.
Always go through `sops`, which decrypts to a temporary file and re-encrypts
on save:

```bash
nix-shell -p sops
sops secrets/users.yaml
```

`.sops.yaml` lists two recipients: the host key at
`/var/lib/sops-nix/key.txt`, and a personal key kept in the password manager.
After adding or rotating a recipient, re-encrypt existing secrets:

```bash
sops updatekeys secrets/users.yaml
```

## Updating packages

```bash
cd ~/nixos
nix flake update
sudo nixos-rebuild switch --flake .#gustavo-nixos
```
