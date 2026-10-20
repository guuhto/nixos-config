{ ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "gemma4:e2b" "gpt-oss:20b" ];
    environmentVariables = {
      OLLAMA_MAX_LOADED_MODELS = "1";
    };
  };

  systemd.services.ollama.serviceConfig = {
    MemoryMax = "7G";
    MemorySwapMax = "2G";
    Restart = "on-failure";
    RestartSec = 5;
  };
}
