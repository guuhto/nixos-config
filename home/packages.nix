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

    # Gaming
    jdk21
    prismlauncher

    # Shell Utilities
    bat
    fastfetch
    ffmpegthumbnailer
    fzf
    imagemagick
    mediainfo
    nnn
    poppler-utils
    ueberzugpp
    zsh-powerlevel10k

    # Terminals
    kitty
    warp-terminal

    # Office
    obsidian
    onlyoffice-desktopeditors
    speedcrunch
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
    zapzap

    # Peripherals
    solaar

    # Cloud
    megasync
    nextcloud-client

    # App Center
    bazaar
  ];
}
