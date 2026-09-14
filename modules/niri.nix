{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    noctalia-shell
    quickshell
    xwayland-satellite
    wl-clipboard
    brightnessctl
    adwaita-icon-theme
    kdePackages.polkit-kde-agent-1
  ];

  # Portais: compartilhamento de tela, seletor de arquivos e preferência
  # de tema escuro para apps GTK e Electron.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.niri = {
      default = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  # dconf guarda a preferência de tema escuro lida pelos apps modernos.
  programs.dconf.enable = true;

  security.polkit.enable = true;
}
