# home-hyprland.nix

{ pkgs, ... }: {
  home.packages = with pkgs; [
    waybar
    wofi
    mako
    hyprpaper
    hyprlock
    wlogout
    grim
    slurp
    wl-clipboard
    kitty
    nautilus
    brightnessctl
    playerctl
  ];

  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1.5
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
    }

    decoration {
      rounding = 4
      blur {
        enabled = true
        size = 6
        passes = 3
      }
    }

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

    # Volume (PipeWire via Pulse)
    bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
    bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
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
    preload = /usr/share/backgrounds/gnome/adwaita-day.jpg
    wallpaper = ,/usr/share/backgrounds/gnome/adwaita-day.jpg
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background { path=/usr/share/backgrounds/gnome/adwaita-day.jpg }
  '';

  xdg.configFile."mako/config".text = ''
    font=Sans 10
    default-timeout=5000
    corner-radius=8
  '';

  xdg.configFile."waybar/config.jsonc".text = ''
    { "position":"top",
      "modules-left":["hyprland/workspaces"],
      "modules-center":["clock"],
      "modules-right":["network","battery","tray"],
      "clock":{"format":"{:%a %Y-%m-%d  %H:%M}"}
    }
  '';
  # xdg.configFile."waybar/style.css".text = '* { font-family: Sans; font-size: 12px; }';
}
