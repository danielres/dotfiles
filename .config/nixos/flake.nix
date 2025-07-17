{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:dc-tec/nixvim";
    # nix-software-center.url = "github:snowfallorg/nix-software-center";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      # nix-software-center,
      ...
    }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
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
