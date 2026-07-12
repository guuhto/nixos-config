{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Minecraft
    prismlauncher
    jdk21

    # Shell Utilities
    fastfetch
    zsh-powerlevel10k
    nnn
    bat
    ueberzugpp
    fzf
    ffmpegthumbnailer
    imagemagick
    poppler-utils
    mediainfo

    # Terminais
    warp-terminal
    kitty   
 
    # Development
    # Tools
    git
    gh
    vscodium
    zed-editor
    # Language
    gcc
    python3
    rustup
    go    
    
    # Office
    speedcrunch
    thunderbird
    onlyoffice-desktopeditors
    obsidian

    # Media
    gimp
    vlc

    # Music
    strawberry
    spotatui

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
