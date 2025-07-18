{
  config,
  pkgs,
  nixvim,
  # nix-software-center,
  ...
}:
{
  home.stateVersion = "25.05";

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.packages = with pkgs; [
    # nixvim.packages.${pkgs.system}.default
    # nix-software-center.packages.${pkgs.system}.default
  ];
}
