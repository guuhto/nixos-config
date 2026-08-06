{ ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
    ".icons/Future-dark-cursors".source = ../config/cursors/Future-dark-cursors;
    ".local/share/color-schemes/SweetAmbarBlue.colors".source = ../config/color-schemes/SweetAmbarBlue.colors;
    ".local/share/icons/GreyStone-circle".source = ../config/icons/GreyStone-circle;
    ".local/share/plasma/desktoptheme/Sweet-Ambar-Blue".source = ../config/plasma-themes/Sweet-Ambar-Blue;
    ".local/share/plasma/plasmoids".source = ../config/plasmoids;
    ".local/share/plasma/wallpapers".source = ../config/plasma-wallpapers;
    ".p10k.zsh".source = ../p10k.zsh;
  };
}
