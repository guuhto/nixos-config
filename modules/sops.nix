{ ... }:
{
  sops.defaultSopsFile = ../secrets/users.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets."gustavo-password".neededForUsers = true;
}
