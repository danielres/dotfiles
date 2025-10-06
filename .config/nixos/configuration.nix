# configuration.nix

# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, ... }:

{
  imports = [ ];

  # nix.settings.auto-optimize-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.cores = 0;
  nix.settings.max-jobs = "auto";

  nix.settings.substituters =
    [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

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

  fonts.packages = [ pkgs.nerd-fonts._0xproto pkgs.nerd-fonts.droid-sans-mono ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.power-profiles-daemon.enable = true;

  # prevent wake-up from suspend by mouse (applies to all devices on the same unifying receiver)
  services.udev.extraRules = ''
    # Logitech USB Receiver only
    ACTION=="add|change", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{product}=="USB Receiver", \
      ATTR{power/wakeup}="disabled"
  '';

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Swap escape & caps lock
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.caps2esc ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
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

  # gamescope
  security.wrappers.gamescope = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+pie";
    source = "${pkgs.gamescope}/bin/gamescope";
  };

#
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

# bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  hardware.uinput.enable = true;

  # Graphics
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # amdgpu.amdvlk = {
    #   enable = true;
    #   support32Bit.enable = true;
    # };
  };

  # hardware.tuxedo-rs = {
  #   enable = true;
  #   tailor-gui.enable = true;
  # };

  # users.users.daniel.extraGroups = [ "input" ]; # read real keyboards
  users.groups.uinput.members = [ "daniel" ];
  users.groups.input.members = [ "daniel" ];

  users.users.daniel = {
    isNormalUser = true;
    description = "daniel";
    #shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  nixpkgs.config.allowUnfree = true;

  # enables make command
  environment.systemPackages = with pkgs; [ linuxPackages.kernel.dev ];

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs = {
    firefox.enable = true;
    fish.enable = true;

    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    gamescope.enable = true; # installs the wrapper
    steam = {
      enable = true;
      gamescopeSession.enable = true; # auto‑wrap every Steam launch
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall =
        true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  services.gnome = {
    sushi.enable = true; # Sushi, a quick previewer for nautilus
    # evolution-data-server.enable = true;
    # glib-networking.enable = true;
    # gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
    gnome-keyring.enable = true;
  };

  services.gvfs.enable = true;

  # Monitor brightness 
  hardware.i2c.enable = true; # Optional: enable I2C for DDC/CI
  services.udev.packages =
    [ pkgs.ddcutil ]; # Install udev rules to access /dev/i2c-* as user

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
  networking.firewall.allowedTCPPorts = [ 4000 4001 ];
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
