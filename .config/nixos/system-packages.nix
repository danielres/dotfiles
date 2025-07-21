# system-packages.nix

{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    any-nix-shell # fish support for nix shell
    atuin
    bash
    bitwarden-cli
    bitwarden-desktop
    btop
    brave
    gnome-control-center
    google-chrome
    cargo
    ddcutil
    dconf
    dconf2nix # dconf (gnome) files to nix converter
    direnv
    duf # disk usage/free utility
    eza # a better `ls`
    fd # "find" for files
    firefox
    fish
    # flameshot
    gcc
    kdePackages.gwenview
    git
    gh
    # gnomeExtensions.VividShade
    # gnomeExtensions.gsconnect
    # gnomeExtensions.sound-output-device-chooser
    # gnomeExtensions.ubuntu-appindicators
    killall # kill processes by name
    lazygit
    neofetch
    neovim
    nerd-fonts.fira-code
    nixfmt
    nixd
    nix-index # locate packages containing certain nixpkgs
    nix-output-monitor # nom: monitor nix commands
    oh-my-fish
    tldr
    tree
    wezterm
    wget
    wl-clipboard
    # xsel
    yazi
    # yaziPlugins
    youtube-music
    zoxide
    # arandr               # simple GUI for xrandr
    # asciinema            # record the terminal
    # bottom               # alternative to htop & ytop
    # calibre              # e-book reader
    # chezmoi
    # dig                  # dns command-line tool
    # dive                 # explore docker layers
    # docker-compose       # docker manager
    # drawio               # diagram design
    # gimp                 # gnu image manipulation program
    # haskell packages
    # haskellPackages.nix-tree # visualize nix dependencies
    # https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/home.nix
    # insomnia             # rest client with graphql support
    # jitsi-meet-electron  # open source video calls and chat
    # jmtpfs               # mount mtp devices
    # libnotify # notify-send command
    # libreoffice          # office suite
    # lnav                 # log file navigator on the terminal
    # multilockscreen      # fast lockscreen based on i3lock
    # ncdu # disk space info (a better du)
    # nitch # minimal system information fetch
    # ouch                 # painless compression and decompression for your terminal
    # paprefs              # pulseaudio preferences
    # pasystray            # pulseaudio systray
    # pavucontrol          # pulseaudio volume control
    # pgcli                # modern postgres client
    # playerctl            # music player controller
    # prettyping           # a nicer ping
    # protonvpn-gui        # official proton vpn client
    # pulsemixer           # pulseaudio mixer
    # rage                 # encryption tool for secrets management
    # ranger               # terminal file explorer
    # simple-scan          # scanner gui
    # simplescreenrecorder # screen recorder gui
    # skypeforlinux        # messaging client
    # slack                # messaging client
    # zoom-us              # message client
    # gnomecast            # chromecast local files
  ];
}
