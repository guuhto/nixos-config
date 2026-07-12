{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./packages.nix
    ./plasma.nix
    ./variables.nix
    ./zsh.nix
    
  ];

  home.username = "gustavo";
  home.homeDirectory = "/home/gustavo";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
