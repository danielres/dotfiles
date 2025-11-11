# home-hyprland.nix

{ pkgs, ... }:
let
  # https://discourse.nixos.org/t/has-anyone-tried-to-get-nautilus-working-with-hm-incl-plugins-but-keeping-gnome3-settings-out-of-the-system-wide-config-and-using-a-wm/30385/7
  nautEnv = pkgs.buildEnv {
    name = "nautilus-env";

    paths = with pkgs; [ nautilus nautilus-python nautilus-open-any-terminal ];
  };
in {
  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR =
    "${nautEnv}/lib/nautilus/extensions-4";
  # home.sessionVariables.PATH = "/home/daniel/.nix-profile/bin:$PATH";

  dconf = {
    enable = true;
    settings."com/github/stunkymonkey/nautilus-open-any-terminal".terminal =
      "wezterm";
  };

  home.packages = with pkgs; [
    nautEnv

    bemoji
    brightnessctl
    cliphist
    dmenu-bluetooth
    networkmanager_dmenu
    fuzzel
    gnome-calculator
    grim

    # All hyprland plugins:
    # https://search.nixos.org/packages?channel=25.05&query=hyprlandPlugins
    hyprlandPlugins.hyprbars
    hyprlandPlugins.hyprexpo
    hyprlandPlugins.hyprspace

    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    libnotify
    networkmanager_dmenu
    nordzy-cursor-theme
    arc-icon-theme
    nwg-displays
    nwg-look
    playerctl
    slurp
    swayimg
    swaynotificationcenter
    syshud
    waybar
    wttrbar
    wasistlos
    wl-clipboard
    wlogout
    wofi
  ];

  home.file.".config/hypr/plugins/hyprbars.so".source =
    "${pkgs.hyprlandPlugins.hyprbars}/lib/libhyprbars.so";

  xdg.desktopEntries = {
    copy_color_hex = {
      name = "Copy color - hex";
      exec = "hyprpicker -a";
      terminal = false;
      categories = [ "System" "Utility" ];
    };

    copy_color_rgb = {
      name = "Copy color - rgb";
      exec = "hyprpicker -f rgb -a";
      terminal = false;
      categories = [ "System" "Utility" ];
    };

    copy_color_hsl = {
      name = "Copy color - hsl";
      exec = "hyprpicker -f hsl -a";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
  };
}
