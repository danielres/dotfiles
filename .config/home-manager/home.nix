# home.nix

{ pkgs, ... }: {
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  # home-manager.users.myuser = {
  #   dconf = {
  #     enable = true;
  #     settings."org/gnome/shell" = {
  #       disable-user-extensions = false;
  #       enabled-extensions = with pkgs.gnomeExtensions; [
  #         blur-my-shell.extensionUuid
  #         gsconnect.extensionUuid
  #       ];
  #     };
  #   };
  # };

  home.sessionVariables = {
    EDITOR = "nvim";
    NVIM_APPNAME = "vim-lazyvim";
    GTK_THEME = "Adwaita:dark";
  };

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

  home.packages = with pkgs; [
    (flameshot.override { enableWlrSupport = true; })
    brave
    cargo
    direnv
    duf # disk usage/free utility
    eza # a better `ls`
    fd # "find" for files
    firefox
    gh
    gimp3-with-plugins
    glow # terminal markdown viewer
    gnome-control-center
    gnomeExtensions.bitcoin-markets
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-history
    gnomeExtensions.color-picker
    gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil
    gnomeExtensions.dash-to-dock
    gnomeExtensions.emoji-copy
    gnomeExtensions.extension-list
    gnomeExtensions.memento-mori
    gnomeExtensions.middle-click-to-close-in-overview
    gnomeExtensions.pop-shell
    google-chrome
    lazygit
    mesa-demos
    neofetch
    nixd
    nixfmt-classic
    obsidian
    oh-my-fish
    pavucontrol
    ripgrep # fast grep
    screenkey # shows keypresses on screen
    starship
    stow
    tdesktop # telegram
    tldr
    veracrypt
    vlc
    wezterm
    zoxide
    # xsel
    wl-clipboard
    yazi
    # yaziPlugins
    youtube-music
  ];

}
