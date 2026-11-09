{ pkgs, lib, inputs, ... }:
let
  llm = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  alpacaPkgs = inputs.nixpkgs-alpaca.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with pkgs; [

    # AI
    (alpacaPkgs.alpaca.overridePythonAttrs (old: {
      dependencies = (old.dependencies or [ ]) ++ [ alpacaPkgs.python3Packages.pandas ];
    }))
    llm.claude-code
    llm.dsh
    llm.opencode
    llm.orca

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
    jetbrains.datagrip
    nodejs_22
    pyright
    (lib.hiPrio rust-analyzer)


    # Gaming
    prismlauncher

    # Shell Utilities
    age
    bat
    btop
    chafa
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
   
    # Themes
    (callPackage ../pkgs/relax-icons.nix { }) 
  
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
    zapzap

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
