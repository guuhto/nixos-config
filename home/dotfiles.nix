{ ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
    ".local/share/aurorae/themes/Sweet-Dark-transparent".source = ../config/plasma/aurorae/Sweet-Dark-transparent;
    ".local/share/color-schemes/CatppuccinMochaMauve.colors".source = ../config/plasma/color-schemes/CatppuccinMochaMauve.colors;
    ".local/share/plasma/desktoptheme/Sweet".source = ../config/plasma/desktoptheme/Sweet;
    ".local/share/plasma/plasmoids".source = ../config/plasma/plasmoids;
    ".local/share/plasma/wallpapers".source = ../config/plasma/wallpapers;
    ".p10k.zsh".source = ../config/p10k.zsh;
  };
}
