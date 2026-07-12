{
  description = "Powered by flakes and bad decisions";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = { self, nixpkgs, spicetify-nix, home-manager, plasma-manager, ... }: {
    nixosConfigurations.gustavo-nixos =
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit spicetify-nix;
        };
        modules = [
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./configuration.nix
          spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gustavo = import ./home/default.nix;
            home-manager.sharedModules = [
              plasma-manager.homeModules.plasma-manager
            ];
          }
        ];
      };
  };
}
