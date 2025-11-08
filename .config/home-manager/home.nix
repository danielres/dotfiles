# home.nix

{ pkgs, inputs, ... }: {
  home.stateVersion = "25.05";
  home.sessionVariables = { GTK_THEME = "Adwaita:dark"; };
  imports = [ inputs.xremap-flake.homeManagerModules.default ];

  nixpkgs.config.allowUnfree = true;

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  # home-manager.users.daniel = {
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
    # GTK_THEME = "Adwaita:dark";
  };

  services.xremap = {
    # key codes: https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L26-L572
    enable = true;
    withGnome = true;
    watch = true;
    config = {
      keymap = [
        {
          name = "Ctrl-u → PageUp";
          remap = { "C-u" = "PAGEUP"; }; # valid single-line binding
        }
        {
          name = "Launchers"; # Super-d  then f / t / s
          remap = {
            "Alt-i" = {
              remap = { # ← missing in your file
                b = { launch = [ "gnome-control-center" "bluetooth" ]; };
                c = { launch = [ "google-chrome-stable" ]; };
                f = { launch = [ "firefox" ]; };
                g = {
                  launch =
                    [ "firefox" "https://mail.google.com/mail/u/0/#inbox" ];
                };
                m = { launch = [ "firefox" "https://www.google.com/maps" ]; };
                o = { launch = [ "obsidian" ]; };
                s = { launch = [ "pavucontrol" ]; };
                t = { launch = [ "Telegram" ]; };
                z = { launch = [ "youtube-music" ]; };
                # timeout_key = null;
                # timeout_milis = 300;
              };
            };
          };
        }
      ];
    };
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
      set -g fish_key_bindings fish_vi_key_bindings

      function fish_user_key_bindings
        bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
        bind -M default p "fish_clipboard_paste"
      end

      function fish_mode_prompt
          switch $fish_bind_mode
              case default
                  set_color green --bold
                  echo 'N '
              case insert
                  set_color blue --bold
                  echo 'I '
              case visual
                  set_color red --bold
                  echo 'V '
          end
      end
    '';

    shellAliases = {
      hms = "home-manager switch --flake ~/dotfiles/.config/nixos#daniel";
      rebuild = "sudo nixos-rebuild switch";
    };
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
    package = pkgs.gitFull;
  };
  #
  # # home.pointerCursor = {
  # #   gtk.enable = true;
  # #   x11.enable = true;
  # #   name = "Adwaita";
  # #   size = 24;
  # #   package = pkgs.adwaita-icon-theme;
  # # };
  #

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    #   (flameshot.override { enableWlrSupport = true; })
    ack
    audacity
    bat
    bat-extras.core
    brave
    cargo
    calibre
    celluloid
    # darktable
    direnv
    dissent
    easyeffects
    #   duf # disk usage/free utility
    #   eza # a better `ls`
    #   fd # "find" for files
    file-roller
    firefox
    fzf
    #   gh
    gimp3-with-plugins
    gthumb
    #   glow # terminal markdown viewer
    gnome-control-center
    gnomeExtensions.bitcoin-markets
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-history
    gnomeExtensions.color-picker
    gnomeExtensions.control-monitor-brightness-and-volume-with-ddcutil
    gnomeExtensions.dash-to-dock
    #   gnomeExtensions.emoji-copy
    #   gnomeExtensions.extension-list
    gnomeExtensions.memento-mori
    gnomeExtensions.middle-click-to-close-in-overview
    gnomeExtensions.pop-shell
    gnomeExtensions.xremap
    gnome-tweaks
    gnumake
    google-chrome
    gtk3
    jq
    # kdenlive
    lazygit
    delta
    loupe
    #   mesa-demos
    nautilus-open-any-terminal
    ncdu
    neofetch
    nixd
    nixfmt-classic
    nodejs_latest
    obsidian
    oh-my-fish
    oklch-color-picker
    # openshot-qt
    pavucontrol
    powertop
    python3
    rclone
    # qpwgraph
    # peek
    # pick-colour-picker
    # rclone
    # rclone-browser
    # rclone-ui
    ripgrep # fast grep

    #   screenkey # shows keypresses on screen
    #   starship
    stow
    tdesktop # telegram
    tldr
    tuxedo-rs
    veracrypt
    vidcutter
    vlc
    wezterm
    wev
    wl-clipboard
    # xsel
    yazi
    # yaziPlugins
    youtube-music
    yt-dlp
    ytmdl
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zoxide
  ];

}
