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
      setopt interactivecomments

      # DeepSeek Harness: needs the official Node build (nixpkgs node fails), run via nix-ld.
      dsh() {
        OLLAMA_API_KEY=ollama \
        NIX_LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$NIX_LD_LIBRARY_PATH" \
        PATH="$HOME/.local/opt/node24/bin:$PATH" \
        "$HOME/.local/opt/node24/bin/npx" @deepseek-ai/dsh "$@"
      }

      fastfetch
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  home.file.".dsh/settings.yaml".text = ''
    llm-pi-ai:
      providers:
        ollama:
          displayName: Ollama
          apiKeyEnv: OLLAMA_API_KEY
          api: openai-completions
          baseURL: http://127.0.0.1:11434/v1
          models:
            - id: gemma4:e2b
              name: Gemma 4 E2B
              contextWindow: 32768
              maxTokens: 4096
    agent-default-model:
      provider: ollama
      model: gemma4:e2b
  '';
}
