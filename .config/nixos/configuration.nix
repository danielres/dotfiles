# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./locales.nix
    ./hibernate.nix
    ./root.nix
  ];

  # nix.settings.auto-optimize-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # boot.kernelModules = [ "amdgpu" ];
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelParams = [ "video=1280x720" ];
  boot.initrd.luks.devices."nixoscrypt".device = "/dev/nvme0n1p5";
  boot.resumeDevice = "/dev/disk/by-uuid/cba6b9b8-55cf-46eb-9122-84dd99cb0138";
  swapDevices = [{ device = "/dev/nixos/swap"; }];
  boot.kernelParams = [ "resume=UUID=cba6b9b8-55cf-46eb-9122-84dd99cb0138" ];

  # hardware.enableAllFirmware = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.hostName = "nixos"; # Define your hostname.

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

  users.users.daniel = {
    isNormalUser = true;
    description = "daniel";
    #shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # You can use https://search.nixos.org/ to find more packages (and options).
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
    gimp3-with-plugins
    glow # terminal markdown viewer
    gnomeExtensions.dash-to-dock
    gnomeExtensions.espresso
    gnomeExtensions.pop-shell
    gnomeExtensions.clipboard-history
    gnomeExtensions.middle-click-to-close-in-overview
    # gnomeExtensions.VividShade
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.bitcoin-markets
    gnomeExtensions.color-picker
    # gnomeExtensions.wayland-or-x11
    gnomeExtensions.emoji-copy
    gnomeExtensions.memento-mori
    gnomeExtensions.extension-list
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
    obsidian
    oh-my-fish
    pavucontrol
    ripgrep # fast grep
    screenkey # shows keypresses on screen
    starship
    stow
    tdesktop # telegram
    tldr
    tree
    veracrypt
    vlc
    wezterm
    wget
    xsel
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

  programs.dconf.profiles.user.databases = [{
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
        minimize = [ "" ];
        # maximize = [ "<Super>m" ];
        close = [ "<Control>q" ];
      };

      "org/gnome/shell/extensions/bitcoin-markets" = {
        first-run = false;
        indicators = [
          ''
            {"api":"bitstamp","base":"BTC","quote":"USD","attribute":"last","show_change":true,"format":"{v} {q}"}''
          ''
            {"api":"bitstamp","base":"ETH","quote":"USD","attribute":"last","show_change":true,"format":"{v} {q}"}''
        ];
      };

      "/org/gnome/shell/extensions/emoji-copy" = {
        # active-keybind = false;
        # emoji-keybind = [ "" ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        always-center-icons = false;
        apply-custom-theme = false;
        background-opacity = 0.8;
        custom-background-color = false;
        custom-theme-shrink = true;
        dash-max-icon-size = "uint32 40";
        disable-overview-on-startup = true;
        dock-position = "BOTTOM";
        extend-height = true;
        height-fraction = 0.9;
        intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
        isolate-monitors = false;
        isolate-workspaces = true;
        multi-monitor = true;
        preferred-monitor = "int32 -2";
        preferred-monitor-by-connector = "eDP-1";
        running-indicator-style = "DOTS";
        scroll-action = "cycle-windows";
        shortcut = [ "<Super>q" ];
        shortcut-text = "<Super>q";
        show-favorites = true;
        show-mounts-network = false;
        show-show-apps-button = false;
        show-trash = false;
      };

      "org/gnome/shell/extensions/pop-shell" = {
        active-hint = true;
        active-hint-border-radius = lib.gvariant.mkUint32 4;
        gap-inner = lib.gvariant.mkUint32 0;
        gap-outer = lib.gvariant.mkUint32 0;
        hint-color-rgba = "rgba(187,127,57,0.557432)";
        show-title = true;
        tile-by-default = true;
      };
    };
  }];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
