# home-mangowc.nix

{ pkgs, ... }:
{
  wayland.windowManager.mango.enable = true;

  # xdg.configFile."mango/config.conf".text = ''
  #   bind=ALT,Return,spawn,wezterm
  #   bind=SUPER,r,reload_config
  #   bind=SUPER,m,quit
  # '';

  home.packages = with pkgs; [
    arc-icon-theme
    brightnessctl
    cliphist
    fuzzel
    grim
    libnotify
    nautilus
    networkmanager_dmenu
    nordzy-cursor-theme
    nwg-look
    playerctl
    slurp
    swaybg
    swayimg
    swaynotificationcenter
    syshud
    waybar
    wl-clipboard
    wlogout
    wlsunset
    wttrbar
  ];

  programs.swaylock = {
    enable = true;
    settings = {
      indicator-radius = 120;
      indicator-thickness = 8;
      inside-color = "171829cc";
      ring-color = "7fc8ffcc";
      line-color = "00000000";
      key-hl-color = "b4f9f8cc";
      bs-hl-color = "ff7a90cc";
      text-color = "ffffffff";
      separator-color = "00000000";
      grace = 2;
      fade-in = 0.2;
      show-failed-attempts = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "swaylock -f";
      lock = "swaylock -f";
    };
    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f";
      }
    ];
  };
}
