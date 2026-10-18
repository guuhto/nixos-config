{ ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen3:4b" ];
  };
}
