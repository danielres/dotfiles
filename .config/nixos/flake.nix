# flake.nix

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mangowc.url = "github:mangowm/mango";
    mangowc.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      mangowc,
      hyprland,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            inputs.mangowc.nixosModules.mango
            ./hardware-configuration.nix
            ./boot.nix
            ./locales.nix
            ./hibernate.nix
            ./root.nix
            # ./gnome.nix
            ./system-packages.nix
            ./configuration.nix
            ./hyprland-greetd.nix
            # ./niri-greetd.nix
            # ./mangowc.nix
            ./kde-connect.nix
            ./noctalia.nix
          ];
        };
      };

      homeConfigurations = {
        daniel = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            inputs.mangowc.hmModules.mango
            ##
            ../home-manager/home.nix
            ../home-manager/home-hyprland.nix
            # ../home-manager/home-niri.nix
            # ../home-manager/home-mangowc.nix
          ];
        };
      };
    };
}
