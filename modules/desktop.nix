{ lib, ... }:
{
  services.xserver.enable = true;

  services.displayManager.defaultSession = lib.mkForce "plasma";

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = false;
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  services.printing.enable = true;
}
