# home.nix

{ pkgs, inputs, ... }: {
  home.stateVersion = "25.05";
  home.sessionVariables = { GTK_THEME = "Adwaita:dark"; };

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

  # add paths to PATH 
  home.sessionPath = [
    #
    "$HOME/.npm-global/bin"
    "$HOME/dotfiles/.local/bin"
  ];

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick pkgs.elixir ];
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
      # hms = "home-manager switch --flake ~/dotfiles/.config/nixos#daniel";
      # rebuild = "sudo nixos-rebuild switch";
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

  programs.neovide = {
    enable = true;
    # settings = {
    # };
    # package = pkgs.gitFull;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    # essentials
    settings = {
      user = {
        init = { defaultBranch = "main"; };
        name = "Daniel Reszka";
        email = "dannn.r@gmail.com";
      };
      # core = {
      #   editor = "nvim";
      # };
    };

    # setup delta for diffs
    settings = {
      include = {
        # path = "~/.config/delta/themes.gitconfig"; 
        path = "~/.config/delta/catppuccin.gitconfig";
      };
      core = { pager = "delta"; };
      interactive = { diffFilter = "delta --color-only"; };
      delta = {
        navigate = true;
        syntax-theme = "Dracula"; # for dark backgrounds
        features = "villsau";
      };
      merge = { conflictStyle = "zdiff3"; };
    };
  };

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

  programs.yazi = {
    enable = true;
    plugins = {
      projects = pkgs.yaziPlugins.projects;
      glow = pkgs.yaziPlugins.glow;
      vcs-files = pkgs.yaziPlugins.vcs-files;
      git = pkgs.yaziPlugins.git;
    };
    settings = {
      mgr = { show_hidden = true; };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    #   (flameshot.override { enableWlrSupport = true; })
    ack
    audacity
    bat
    # bat-extras.core
    brave
    cargo
    calibre
    celluloid
    chromium
    # darktable
    direnv
    discord
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
    go
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
    gnome-tweaks
    gnumake
    google-chrome
    gtk3
    htop
    jq
    # kdenlive
    lazygit
    delta
    kitty
    loupe
    mpv
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
    qdirstat
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
    sqlite
    sqlitestudio
    telegram-desktop
    tldr
    tuxedo-rs
    unzip
    vectorcode
    veracrypt
    vidcutter
    vlc
    wezterm
    wev
    wl-clipboard
    wl-color-picker
    xnviewmp
    # xsel
    youtube-music
    yt-dlp
    ytmdl
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zoxide
  ];

}
