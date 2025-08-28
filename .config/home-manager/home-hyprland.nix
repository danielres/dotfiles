# home-hyprland.nix

{ pkgs, ... }: {
  home.packages = with pkgs; [
    bemoji
    brightnessctl
    fuzzel
    grim
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    kitty
    mako
    nautilus
    networkmanager_dmenu
    playerctl
    slurp
    waybar
    wl-clipboard
    wlogout
    wofi
  ];

  xdg.configFile."wofi/config".text = ''
    insensitive=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
    margin: 0px;
    border: 1px solid rgba(0,0,0,0.25);
    border-radius: 8px;
    background-color: rgba(0, 0, 0, 0.4); /* semi-transparent */
    }

    #input {
    margin: 5px;
    border: 1px solid white;
    background-color: white;
    color: black;
    }

    #inner-box {
    margin: 5px;
    border: 0px solid yellow;
    background-color: transparent;
    }

    #outer-box {
    margin: 5px;
    border: 0px solid transparent;
    background-color: transparent;
    }

    #scroll {
    margin: 5px;
    border: 0px solid orange;
    background-color: transparent;
    }

    #text {
    margin: 0px;
    border: 0px solid cyan;
    color: white;
    } 

    #entry:selected {
    background-color: rgba(0,0,0,0.75);
    color: white;
    } 

    #text:selected {
    background-color: transparent;
    } 
  '';

  xdg.desktopEntries = {
    lock = {
      name = "Lock Screen";
      exec = "hyprlock";
      terminal = false;
      icon = "system-lock-screen";
      categories = [ "System" "Utility" ];
    };
    suspend = {
      name = "Power - Suspend";
      exec = "systemctl suspend";
      terminal = false;
      icon = "system-suspend";
      categories = [ "System" "Utility" ];
    };
    reboot = {
      name = "Power - Reboot";
      exec = "systemctl reboot";
      terminal = false;
      icon = "system-reboot";
      categories = [ "System" "Utility" ];
    };
    shutdown = {
      name = "Power - Shutdown";
      exec = "systemctl poweroff";
      terminal = false;
      icon = "system-shutdown";
      categories = [ "System" "Utility" ];
    };
    logout = {
      name = "Logout (Hyprland)";
      exec = "hyprctl dispatch exit";
      terminal = false;
      icon = "system-log-out";
      categories = [ "System" "Utility" ];
    };
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

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg
    wallpaper = ,/home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      grace = 0
      hide_cursor = true
    }

    # Use either a solid/blurred background, or a wallpaper path (pick one)

    # Option A: blur current screen (hides contents)
    #background {
    #  color = rgba(0,0,0,0.6)
    #  blur_passes = 3
    #  blur_size = 6
    #}

    # Option B: static image
    background {
      path = /home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg
      blur_passes = 4
    }

    # Centered password field
    input-field {
      monitor =
      fade_on_empty = false
      size = 320, 48
      position = 0, -10
      halign = center
      valign = center

      placeholder_text =
      outline_thickness = 0
      dots_center = true

      inner_color = rgba(255,255,255,0.6)   # semi-transparent fill
      outer_color = rgba(255,255,255,0.8) # semi-transparent border
      font_color = #333366
    }

    label {
      text = $TIME
      font_size = 16
      halign = center
      valign = center
      position = 0, 40
    }
  '';

  xdg.configFile."mako/config".text = ''
    font=Sans 10
    default-timeout=5000
  '';
}
