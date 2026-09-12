{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
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
    onlyoffice-desktopeditors
    libreoffice-qt
    qalculate-gtk
    thunderbird

    # Media
    gimp
    vlc

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
