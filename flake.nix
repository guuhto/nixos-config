{
  description = "Powered by flakes and bad decisions";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
        # Alpaca only: its Python deps are broken on nixos-unstable after 2026-11-05.
    # Pinned to the last revision that built; drop once unstable is fixed.
    nixpkgs-alpaca.url = "github:NixOS/nixpkgs/f9a75f41be3a74eab55d3a7679d34ad6cc0da977";
    # No nixpkgs.follows on purpose: builds must match cache.numtide.com.
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  outputs = inputs@{ home-manager, nixpkgs, plasma-manager, self, sops-nix, spicetify-nix, ... }: {
    nixosConfigurations.gustavo-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs spicetify-nix;
      };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configuration.nix
        home-manager.nixosModules.home-manager
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
