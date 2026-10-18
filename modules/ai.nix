{ ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "gemma4:e2b" "gpt-oss:20b" ];
  };
}
