{ ... }:
{
  home.file = {
    ".config/fastfetch".source = ../config/fastfetch;
    ".config/kitty".source = ../config/kitty;
    ".p10k.zsh".source = ../p10k.zsh;
    ".config/spotatui".source = ../config/spotatui;
    ".config/nnn".source = ../config/nnn;
    ".config/zed".source = ../config/zed;
  };
}
