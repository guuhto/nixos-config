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
│   ├── rclone.conf            # rclone remotes (binary secret)
│   └── users.yaml             # gustavo's password hash
├── pkgs/                      # Local packages not in nixpkgs
│   └── goanime.nix
├── modules/                   # System modules
│   ├── ai.nix                 # Ollama (CPU only, memory-capped)
│   ├── audio.nix
│   ├── bluetooth.nix
│   ├── boot.nix
│   ├── desktop.nix
│   ├── flatpak.nix
│   ├── fonts.nix
│   ├── network.nix
│   ├── programs.nix
│   ├── proton.nix             # Proton VPN + WireGuard tools
│   ├── sops.nix
│   ├── users.nix
│   └── virtualization.nix
├── home/                      # User configuration (Home Manager)
│   ├── agentcraft.nix         # AgentCraft Foreman user service (manual start)
│   ├── autostart.nix
│   ├── default.nix
│   ├── dotfiles.nix
│   ├── git.nix
│   ├── java.nix               # JDK 17/21/25 under ~/.jdks for Prism Launcher
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
        ├── color-schemes/     # Catppuccin Mocha Mauve
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

Expect a while: the first build pulls tens of GB, plus ~19 GB of Ollama
models in the background. AI agent tools come prebuilt from
`cache.numtide.com` (see [AI tools](#ai-tools)).

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
sudo nixos-rebuild switch --flake .#gustavo-nixos \
  --option extra-substituters https://cache.numtide.com \
  --option extra-trusted-public-keys niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=
```

The two `--option` flags are only needed on this first build: the numtide
cache is declared in `configuration.nix`, but the running Nix daemon does not
know about it yet. Without them, Orca and friends compile from source.

Then point `/etc/nixos` at the flake, so a bare `sudo nixos-rebuild switch`
works from anywhere:

```bash
sudo rm -rf /etc/nixos
sudo ln -s /home/gustavo/nixos /etc/nixos
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

The Plasma style and window decoration are stock Breeze. The color scheme
(Catppuccin Mocha Mauve) and third-party widgets are vendored in
`config/plasma/`; the cursors come from nixpkgs. All of them are declared in
`home/plasma.nix` and apply automatically.

The icon theme is the exception: **Hatter-kde-dark** (by
[Mibea](https://github.com/Mibea/Hatter)) is not packaged. Install it from
System Settings → Icons → *Get New…*.

Never apply a **Global Theme** afterwards: it overwrites icons, colors, style
and decoration in one go.

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

### 8. Sync the wallpapers

Both wallpapers live in cloud storage and are not in this repo — the static
one is a PNG, the live one a 1440p MP4. Until they are synced, the desktop
falls back to a plain background.

### 9. Local AI and agents

- **Alpaca**: add an instance of type **Ollama (External)** pointing at
  `http://127.0.0.1:11434`. Don't use "Managed" — it spawns a second Ollama.
- **opencode**: `/connect` → OpenCode Zen → pick a free zero-retention model.
- **Orca**: launch with `orca-ide` (`orca` is its CLI).
- **dsh** (DeepSeek Harness): `dsh web`; on the first screen pick
  *Configure later* to stay on the local Ollama.

## Known manual steps

| What | Why |
|---|---|
| age key | Must be at `/var/lib/sops-nix/key.txt` before the first rebuild |
| SSH key | Generated per machine, registered on GitHub by hand |
| Panel layout | `appletsrc.backup`, copied by hand |
| Spotify OAuth | Token expires every 6 months |
| Nextcloud login | Autostart is declared, but the client needs a one-time sign-in |
| Wallpapers | Live in cloud storage, too large to vendor |
| Hatter icons | Installed from the KDE Store, not packaged |
| `/etc/nixos` link | Installer creates a real directory; replace it with a link to the flake |
| Alpaca instance | Ollama (External) at `127.0.0.1:11434`, set in the app |
| `virsh net-start default` | libvirt's default network isn't auto-started |

## Updating configuration

New files must be staged before rebuilding — flakes only see tracked paths.
**An unstaged edit does not raise an error:** the build succeeds and silently
uses the previous version of the file. If a change appears to have no effect,
check `git status` first.

```bash
cd ~/nixos
git add .
sudo nixos-rebuild switch
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
sudo nixos-rebuild switch
```

`nix flake update` also bumps `llm-agents`, which is rebuilt daily — that is
how Orca, opencode, dsh and Claude Code stay current.

## AI tools

| Piece | Where | Notes |
|---|---|---|
| Ollama | `modules/ai.nix` | CPU only (Vega 8 iGPU has no ROCm). Capped at 12 GB RAM + 4 GB swap and auto-restarts, so an oversized model kills only Ollama |
| Models | `loadModels` | `gemma4:e2b` for daily use. `gpt-oss:20b` fits in 16 GB but is slow on CPU — close heavy apps first |
| Alpaca | `home/packages.nix` | Overridden to add `pandas`, missing in nixpkgs 9.2.5. Drop the override once nixpkgs fixes it |
| Orca, opencode, dsh, Claude Code | [`numtide/llm-agents.nix`](https://github.com/numtide/llm-agents.nix) | Flake input without `nixpkgs.follows` on purpose, so builds match `cache.numtide.com` |

The GNOME **Orca screen reader** is disabled in `modules/desktop.nix`
(`services.orca.enable = false`) — accessibility isn't used, and it shared
the `orca` command name with the Orca IDE.
