{ pkgs, ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/kitty/current-theme.conf".source = ../config/kitty/current-theme.conf;
    # nixpkgs ships the OpenLogi icon only as 1024x1024, a size hicolor does not
    # index, so launchers show "?". Expose it under a size that is looked up.
    ".local/share/icons/hicolor/512x512/apps/openlogi.png".source =
      "${pkgs.openlogi}/share/icons/hicolor/1024x1024/apps/openlogi.png";
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
    ".local/share/color-schemes/CatppuccinMochaMauve.colors".source = ../config/plasma/color-schemes/CatppuccinMochaMauve.colors;
    ".local/share/plasma/plasmoids".source = ../config/plasma/plasmoids;
    ".local/share/plasma/wallpapers".source = ../config/plasma/wallpapers;
    ".p10k.zsh".source = ../config/p10k.zsh;
  };
}
