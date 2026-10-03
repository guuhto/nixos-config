{ ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
    ".icons/Future-dark-cursors".source = ../config/plasma/cursors/Future-dark-cursors;
    ".local/share/color-schemes/SweetAmbarBlue.colors".source = ../config/plasma/color-schemes/SweetAmbarBlue.colors;
    ".local/share/icons/GreyStone-circle".source = ../config/plasma/icons/GreyStone-circle;
    ".local/share/plasma/desktoptheme/Sweet-Ambar-Blue".source = ../config/plasma/desktoptheme/Sweet-Ambar-Blue;
    ".local/share/plasma/plasmoids".source = ../config/plasma/plasmoids;
    ".local/share/plasma/wallpapers".source = ../config/plasma/wallpapers;
    ".p10k.zsh".source = ../config/p10k.zsh;
  };
}
