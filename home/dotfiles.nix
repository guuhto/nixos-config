{ ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
    ".local/share/plasma/plasmoids".source = ../config/plasmoids;
    ".local/share/plasma/wallpapers".source = ../config/plasma-wallpapers;
    ".p10k.zsh".source = ../p10k.zsh;
  };
}
