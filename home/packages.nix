{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
 
    # Alpaca
    (pkgs.alpaca.overridePythonAttrs (old: {
      dependencies = (old.dependencies or [ ]) ++ [ pkgs.python3Packages.pandas ];
    }))

    # Development - Tools
    git
    gh

    # Development - Languages
    gcc
    go
    python3
    rustup

    # Development - LSPs
    clang-tools
    gopls
    nodejs_22
    pyright
    (lib.hiPrio rust-analyzer)

    # Claude
    claude-code

    # Gaming
    jdk21
    prismlauncher

    # Shell Utilities
    age
    bat
    btop
    chafa
    colloid-icon-theme
    eza
    fastfetch
    ffmpeg
    ffmpegthumbnailer
    fzf
    imagemagick
    mediainfo
    nnn
    poppler-utils
    sops
    zsh-powerlevel10k

    # nnn Preview Dependencies
    catdoc
    pandoc
    w3m

    # Terminals
    kitty
    warp-terminal

    # Office
    obsidian
    libreoffice-qt
    qalculate-gtk
    thunderbird
   
    # Media
    gimp
    vlc
    (pkgs.callPackage ../pkgs/goanime.nix { buildGoModule = pkgs.buildGo127Module; })
    mpv    

    # Music
    spotatui
    spotifyd
    strawberry

    # Communication
    discord
    whatsie

    # Peripherals
    sweet-nova

    # Cloud
    nextcloud-client
    rclone  

    # Proton
    protonmail-desktop
    proton-pass
    proton-authenticator-bin

    # App Center
    bazaar
  ];
}
