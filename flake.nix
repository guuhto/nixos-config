{
  description = "Powered by flakes and bad decisions";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # No nixpkgs.follows on purpose: builds must match cache.numtide.com.
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    openlogi = {
      url = "github:AprilNEA/OpenLogi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs@{ home-manager, nixpkgs, openlogi, plasma-manager, self, sops-nix, spicetify-nix, ... }: {
    nixosConfigurations.gustavo-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs spicetify-nix;
      };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configuration.nix
        home-manager.nixosModules.home-manager
        openlogi.nixosModules.default
        sops-nix.nixosModules.sops
        spicetify-nix.nixosModules.default
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.sharedModules = [
            plasma-manager.homeModules.plasma-manager
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gustavo = import ./home/default.nix;
        }
      ];
    };
  };
}
