# home-mangowc.nix

{ pkgs, ... }:
{
  wayland.windowManager.mango.enable = true;

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
    swayimg
    wl-clipboard
    wlogout
    wlsunset
  ];

}
