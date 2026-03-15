# flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./boot.nix
          ./locales.nix
          ./hibernate.nix
          ./root.nix
          # ./gnome.nix
          ./system-packages.nix
          ./configuration.nix
          # ./hyprland-greetd.nix
          ./niri-greetd.nix
          ./kde-connect.nix
        ];
      };
    };

    homeConfigurations = {
      daniel = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        # pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ##
          ../home-manager/home.nix
          # ../home-manager/home-hyprland.nix
          ../home-manager/home-niri.nix
        ];
      };
    };
  };
}
