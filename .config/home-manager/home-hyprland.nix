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

  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor = desc:GIGA-BYTE TECHNOLOGY CO. LTD. M28U, preferred, 0x0, auto
    monitor = eDP-1, preferred, auto-left, auto
    monitor = desc:AOC 2243W, preferred, auto-right, auto

    exec-once = hyprpaper &
    exec-once = mako &
    exec-once = waybar &

    input {
      kb_layout = us
      kb_variant = altgr-intl
      follow_mouse = 1
      # touchpad { natural_scroll = true }
    }

    general {
      gaps_in = 0
      gaps_out = 0
      border_size = 2
      layout = dwindle
      col.active_border=rgb(cdd6f4)
      col.inactive_border = rgba(595959aa)
    }

    decoration {
      rounding = 4
      blur {
        enabled = true
        size = 6
        passes = 3
      }
    }

    layerrule = blur, wofi
    layerrule = blur, waybar
    layerrule = xray, wofi
    layerrule = xray, waybar

    animations {
      enabled = true
      animation = windows, 1, 1.1, default
      animation = border, 1, 1.1, default
      animation = fade, 1, 1.1, default
      animation = workspaces, 1, 1.1, default
    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }

    misc {
      disable_splash_rendering = true
    }

    $mod = SUPER
    bind = $mod, Return, exec, wezterm
    bind = $mod, D, exec, wofi --show drun
    bind = $mod, E, exec, nautilus
    # bind = $mod, L, exec, hyprlock
    bind = $mod, Q, killactive,
    bind = $mod, F, fullscreen,
    bind = $mod, V, togglefloating,
    bind = $mod SHIFT, R, exec, hyprctl reload
    bind = $mod, H, movefocus, l
    bind = $mod, L, movefocus, r
    bind = $mod, K, movefocus, u
    bind = $mod, J, movefocus, d
    bind = $mod SHIFT, H, movewindow, l
    bind = $mod SHIFT, L, movewindow, r
    bind = $mod SHIFT, K, movewindow, u
    bind = $mod SHIFT, J, movewindow, d
    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = , Print, exec, grim - | wl-copy
    bind = SHIFT, Print, exec, slurp | grim -g - - | wl-copy

    bind = $mod, period, workspace, +1
    bind = $mod, comma,  workspace, -1
    bind = $mod SHIFT, period, movetoworkspace, +1
    bind = $mod SHIFT, comma,  movetoworkspace, -1

    # Volume (PipeWire via Pulse)
    binde = , XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
    binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bind = , XF86AudioMute,        exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
    bind = , XF86AudioMicMute,     exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Brightness
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bind = , XF86MonBrightnessUp,   exec, brightnessctl set +5%

    # Media (optional)
    bind = , XF86AudioPlay,  exec, playerctl play-pause
    bind = , XF86AudioNext,  exec, playerctl next
    bind = , XF86AudioPrev,  exec, playerctl previous
  '';

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg
    wallpaper = ,/home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background { path=/home/daniel/Pictures/Wallpapers/hd-Jellyfish.jpg }
  '';

  xdg.configFile."mako/config".text = ''
    font=Sans 10
    default-timeout=5000
  '';

  xdg.configFile."waybar/config.jsonc".text = ''
    { "position":"top",
      "modules-left":["hyprland/workspaces"],
      "modules-center":["clock"],
      "modules-right":["network","battery","tray"],
      "clock":{"format":"{:%a %d-%m  %H:%M}"}
    }
  '';
  # xdg.configFile."waybar/style.css".text = '* { font-family: Sans; font-size: 12px; }';
}
