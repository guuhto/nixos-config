{ config, ... }:
{
  users.mutableUsers = false;
  users.users.gustavo = {
    isNormalUser = true;
    description = "gustavo";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    # Password comes from sops. To change it: mkpasswd -m sha-512, then
    # sops secrets/users.yaml. Test with `su - gustavo` BEFORE logging out —
    # with mutableUsers = false, passwd cannot bail you out.
    hashedPasswordFile = config.sops.secrets."gustavo-password".path;
  };
}
