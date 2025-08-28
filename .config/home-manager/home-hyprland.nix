# home-hyprland.nix

{ pkgs, ... }: {
  home.packages = with pkgs; [
    bemoji
    brightnessctl
    fuzzel
    go
    grim
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    kitty
    mako
    mpv
    nautilus
    networkmanager_dmenu
    playerctl
    slurp
    swayimg
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

  xdg.configFile."mako/config".text = ''
    font=Sans 10
    default-timeout=5000
  '';
}
