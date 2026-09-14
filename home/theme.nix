{ pkgs, ... }:
{
  # Tema escuro para apps GTK (Firefox, Thunderbird, GIMP, apps GNOME).
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme.name = "YAMIS";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.theme = null;
  };

  # É daqui que Firefox, GTK4 e Electron leem "prefira escuro".
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "Adwaita-dark";
  };
}
