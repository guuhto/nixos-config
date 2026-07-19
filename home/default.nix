{ config, pkgs, ... }:
{
  imports = [
    ./dotfiles.nix
    ./git.nix
    ./nvim.nix
    ./packages.nix
    ./plasma.nix
    ./spotifyd.nix
    ./variables.nix
    ./zsh.nix
  ];

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
