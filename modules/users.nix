{ ... }:
{
  users.users.gustavo = {
    isNormalUser = true;
    description = "gustavo";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
  };
}
