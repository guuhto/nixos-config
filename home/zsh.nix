{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    history.path = "$HOME/.cache/zsh/history";
    completionInit = ''
      autoload -Uz compinit
      mkdir -p "$HOME/.cache/zsh"
      compinit -d "$HOME/.cache/zsh/zcompdump"
    '';
    shellAliases = {
      kate = "kate 2>/dev/null";
      nnn = "nnn -P p";
      zed = "zeditor";
    };
    initContent = ''
      fastfetch
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
