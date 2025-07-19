# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./locales.nix
    # ./firefox.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
      "flakes"
  ];
  # nix.settings.auto-optimize-store = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = [ "video=1280x720" ];
  boot.kernelModules = [ "amdgpu" ];

  hardware.enableAllFirmware = true;

  boot.initrd.luks.devices."luks-afe22410-6111-47b4-acb2-74c37cdc9cc9".device = "/dev/disk/by-uuid/afe22410-6111-47b4-acb2-74c37cdc9cc9";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Display
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = false;
  services.desktopManager.gnome.enable = true;

  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    description = "daniel";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    any-nix-shell # fish support for nix shell
    atuin
    bash
    bitwarden-cli # command-line client for the password manager
    cargo
    dconf
    dconf2nix # dconf (gnome) files to nix converter
    direnv
    duf # disk usage/free utility
    eza # a better `ls`
    fd # "find" for files
    firefox
    fish
    gcc
    git
    gh
    glow # terminal markdown viewer
    gnomeExtensions.dash-to-dock
    gnomeExtensions.espresso
    gnomeExtensions.pop-shell
    killall # kill processes by name
    lazygit
    neofetch
    neovim
    nerd-fonts.fira-code
    nixfmt
    nixd
    nix-index # locate packages containing certain nixpkgs
    nix-output-monitor # nom: monitor nix commands
    obsidian
    oh-my-fish
    ripgrep # fast grep
    screenkey # shows keypresses on screen
    starship
    stow
    tdesktop # telegram
    tldr
    tree
    vlc
    wezterm
    wget
    xsel
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

  # List all gnome kbd shortcuts using <Super>:
  # gsettings list-recursively | grep '<Super>'

  xdg.mime = {
    enable = true; # generate /etc/xdg/mimeapps.list
    defaultApplications = {
      "text/html" = "firefox.desktop"; # Ordinary HTML files
      # URL schemes
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        # "org/gnome/desktop/interface" = {
        #   accent-color = "blue";
        # };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "caps:swapescape" ];
        };
        "org/gnome/desktop/wm/keybindings" = {
          toggle-message-tray = [ "<Super>v" ];
          toggle-maximized = [ "<Super>m" ];  
          minimize = [""];
          # maximize = [ "<Super>m" ];
          close = [ "<Control>q" ];
        };
      };
    }
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
