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

  home.sessionVariables = {
    EDITOR = "nvim";
    NVIM_APPNAME="vim-lazyvim";
  };

  home.packages = with pkgs; [
    # nixvim.packages.${pkgs.system}.default
    # nix-software-center.packages.${pkgs.system}.default
  ];

  programs.fish = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName  = "Daniel Reszka";
    userEmail = "dannn.r@gmail.com";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

}
