# home-hyprland.nix

{ pkgs, ... }: {
  home.packages = with pkgs; [
    bemoji
    brightnessctl
    cliphist
    fuzzel
    go
    grim
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    kitty
    libnotify
    mpv
    nautilus
    networkmanager_dmenu
    nordzy-cursor-theme
    arc-icon-theme
    nwg-displays
    nwg-look
    playerctl
    slurp
    swayimg
    syshud
    waybar wttrbar
    whatsapp-for-linux
    wl-clipboard
    wlogout
    wofi
  ];

  services.swaync = {
    enable = true;
  };

  home.file.".config/hypr/plugins/hyprbars.so".source =
    "${pkgs.hyprlandPlugins.hyprbars}/lib/libhyprbars.so";
  home.file.".config/hypr/plugins/hyprexpo.so".source =
    "${pkgs.hyprlandPlugins.hyprexpo}/lib/libhyprexpo.so";

  xdg.configFile."wofi/config".text = ''
    allow_images=false
    allow_markup=true
    close_on_focus_loss=true
    gtk_dark=true
    image_size=16
    insensitive=true
    key_down=Ctrl-j,Ctrl-n
    key_expand=Ctrl-l
    key_up=Ctrl-k,Ctrl-p
    matching=fuzzy
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
      exec = ''sh -c "hyprlock & disown && systemctl suspend"'';
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

    power_performance = {
      name = "Power profile - performance";
      exec = "powerprofilesctl set performance";
      terminal = false;
      # icon = "system-shutdown";
      categories = [ "System" "Utility" ];
    };
    power_balanced = {
      name = "Power profile - balanced";
      exec = "powerprofilesctl set balanced";
      terminal = false;
      # icon = "system-shutdown";
      categories = [ "System" "Utility" ];
    };
    power_saver = {
      name = "Power profile - saver";
      exec = "powerprofilesctl set power-saver";
      terminal = false;
      # icon = "system-shutdown";
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

    brightness_monitor2_25 = {
      name = "Set brightness - Monitor2: 25";
      exec = "ddcutil --display 2 setvcp 10 25";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    brightness_monitor2_50 = {
      name = "Set brightness - Monitor2: 50";
      exec = "ddcutil --display 2 setvcp 10 50";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    brightness_monitor2_75 = {
      name = "Set brightness - Monitor2: 75";
      exec = "ddcutil --display 2 setvcp 10 75";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    brightness_monitor2_100 = {
      name = "Set brightness - Monitor2: 100";
      exec = "ddcutil --display 2 setvcp 10 100";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    brightness_monitor3_50 = {
      name = "Set brightness - Monitor3: 50";
      exec = "ddcutil --display 1 setvcp 10 50";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    brightness_monitor3_100 = {
      name = "Set brightness - Monitor3: 100";
      exec = "ddcutil --display 1 setvcp 10 100";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    enable_touchpad = {
      name = "Enable touchpad";
      exec = "hyprctl keyword device[pnp0c50:00-093a:0255-touchpad]:enabled true";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
    disable_touchpad = {
      name = "Disable touchpad";
      exec = "hyprctl keyword device[pnp0c50:00-093a:0255-touchpad]:enabled false";
      terminal = false;
      categories = [ "System" "Utility" ];
    };
  };

  # xdg.configFile."mako/config".text = ''
  #   font=Sans 10
  #   default-timeout=15000
  # '';
}
