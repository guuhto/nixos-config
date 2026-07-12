{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  programs.firefox.enable = true;
  programs.steam.enable = true;

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
