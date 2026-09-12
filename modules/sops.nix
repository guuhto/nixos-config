{ ... }:
{
  sops.defaultSopsFile = ../secrets/users.yaml;

  sops.age = {
    keyFile = "/var/lib/sops-nix/key.txt";
    sshKeyPaths = [ ];
    generateKey = false;
  };

  sops.secrets."gustavo-password".neededForUsers = true;
  
  sops.secrets."rclone.conf" = {
    format = "binary";
    sopsFile = ../secrets/rclone.conf;
    owner = "gustavo";
    mode = "0400";
  };
}
