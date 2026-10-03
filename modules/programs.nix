{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.openlogi.enable = true;

  # Lets prebuilt binaries run on NixOS. The library list covers the
  # Chromium that playwright-go downloads for GoAnime's SuperFlix source.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glib
      nspr
      nss
      at-spi2-core    # libatk, libatk-bridge, libatspi
      dbus
      cups
      expat
      libgbm
      libxkbcommon
      alsa-lib
      cairo
      pango
      systemd         # libudev
      xorg.libxcb
      xorg.libX11
      xorg.libXext
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXfixes
      xorg.libXrandr
    ];
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
