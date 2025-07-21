{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:dc-tec/nixvim";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # inputs.stylix.nixosModules.stylix
          home-manager.nixosModules
          home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.daniel = import ./home.nix;

            # ✅ Pass nixvim into the home.nix module
            home-manager.extraSpecialArgs = {
              nixvim = nixvim;
              # nix-software-center = nix-software-center;
            };
          }
        ];
      };
    };
  };
}

