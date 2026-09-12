{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-vpn
    wireguard-tools
  ];
}
