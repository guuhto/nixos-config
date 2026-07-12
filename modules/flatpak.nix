{ pkgs, ... }:
{
  services.flatpak.enable = true;
  system.activationScripts.flathub = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
