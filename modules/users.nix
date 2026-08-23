{ config, ... }:
{
  users.mutableUsers = false;
  users.users.gustavo = {
    isNormalUser = true;
    description = "gustavo";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    hashedPasswordFile = config.sops.secrets."gustavo-password".path;
  };
}
