# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, spicetify-nix, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/ai.nix
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    ./modules/network.nix
    ./modules/programs.nix
    ./modules/proton.nix
    ./modules/sops.nix
    ./modules/users.nix
    ./modules/virtualization.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyfinal: pyprev: {
          # 3.17.0's Whisper API tests need network, which the build sandbox
          # doesn't have. Drop once nixpkgs disables them upstream.
          speechrecognition = pyprev.speechrecognition.overridePythonAttrs (old: {
            disabledTestPaths = (old.disabledTestPaths or [ ]) ++ [
              "tests/recognizers/whisper_api/test_openai.py"
            ];
          });
        })
      ];
    })
  ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
