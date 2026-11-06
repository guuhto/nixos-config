{ pkgs, ... }:
{
  programs.zsh = {
    autosuggestion.enable = true;
    completionInit = ''
      autoload -Uz compinit
      mkdir -p "$HOME/.cache/zsh"
      compinit -d "$HOME/.cache/zsh/zcompdump"
    '';
    enable = true;
    enableCompletion = true;
    history.path = "$HOME/.cache/zsh/history";
    initContent = ''
      setopt interactivecomments

      # dsh's settings.yaml reads the Ollama key from here. Ollama ignores it,
      # but dsh refuses to start a provider without one.
      export OLLAMA_API_KEY=ollama

      # Fallback while testing the llm-agents dsh: the old npx route on the
      # official Node build. Delete it, and ~/.local/opt/node24, once `dsh web` works.
      dsh-npx() {
        NIX_LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$NIX_LD_LIBRARY_PATH" \
        PATH="$HOME/.local/opt/node24/bin:$PATH" \
        "$HOME/.local/opt/node24/bin/npx" @deepseek-ai/dsh "$@"
      }

      fastfetch
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    shellAliases = {
      kate = "kate 2>/dev/null";
      nnn = "nnn -P p";
      zed = "zeditor";
    };
    syntaxHighlighting.enable = true;
  };

  home.file.".dsh/settings.yaml".text = ''
    agent-default-model:
      model: gemma4:e2b
      provider: ollama
    llm-pi-ai:
      providers:
        ollama:
          api: openai-completions
          apiKeyEnv: OLLAMA_API_KEY
          baseURL: http://127.0.0.1:11434/v1
          displayName: Ollama
          models:
            - contextWindow: 32768
              id: gemma4:e2b
              maxTokens: 4096
              name: Gemma 4 E2B
  '';
}
