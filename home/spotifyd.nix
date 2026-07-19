{ pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "gustavo-nixos-daemon";
        bitrate = 320;
        backend = "pulseaudio";
      };
    };
  };
}
