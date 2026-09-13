{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    noctalia-shell
    quickshell
    xwayland-satellite
    awww
    wl-clipboard
  ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = false;
}
