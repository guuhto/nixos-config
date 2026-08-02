{ ... }:
{
  home.file = {
    ".config/nnn/bookmarks".source = ../config/nnn/bookmarks;
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    ".config/nnn/plugins".source = ../config/nnn/plugins;
    ".p10k.zsh".source = ../p10k.zsh;
    ".config/spotatui/config.yml".source = ../config/spotatui/config.yml;
  };
}
