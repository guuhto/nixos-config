{ ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";
    };
  };
}
