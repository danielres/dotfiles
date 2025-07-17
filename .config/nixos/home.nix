{
  config,
  pkgs,
  nixvim,
  ...
}:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # nixvim.packages.${pkgs.system}.default
  ];
}
