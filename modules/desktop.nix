{ ... }:
{
  services.xserver.enable = true;

  # Closing the lid with an external display attached keeps the session
  # running; KWin then turns the internal panel off on its own.
  services.logind.settings.Login = {
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitch = "suspend";
  };

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = false;
    # No touchscreen here — keep the on-screen keyboard off the login screen.
    settings.General.InputMethod = "";
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  services.printing.enable = true;
}
