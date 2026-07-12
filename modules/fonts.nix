{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    fira-code
    jetbrains-mono
    font-awesome
    nerd-fonts.meslo-lg
  ];
}
