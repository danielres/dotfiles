# home.nix

{ config, pkgs,
# nix-software-center,
... }: {
  home.stateVersion = "25.05";

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  home.sessionVariables = {
    EDITOR = "nvim";
    NVIM_APPNAME = "vim-lazyvim";
    GTK_THEME = "Adwaita:dark";
  };

  # home.packages = with pkgs;
  #   [
  #     nixvim.packages.${pkgs.system}.default
  #     nix-software-center.packages.${pkgs.system}.default
  #   ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      atuin init fish | source;
      zoxide init fish | source;
      fish_vi_key_bindings;
      fish_vi_cursor;

      # Enforce editor override regardless of inherited env
      set -gx EDITOR nvim
    '';

  };

  programs.bash = {
    enable = true;
    # initExtra = ''
    #   if [ -t 1 ] && [ -z "$IN_FISH_SHELL" ]; then
    #     export IN_FISH_SHELL=1
    #     exec ${pkgs.fish}/bin/fish --login
    #   fi
    # '';
  };

  programs.git = {
    enable = true;
    userName = "Daniel Reszka";
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
