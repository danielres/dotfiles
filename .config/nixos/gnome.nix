{ config, lib, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = with pkgs; [ gnome-settings-daemon ];
    extraGSettingsOverrides = ''
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
      binding='<Super>e'
      command='nautilus'
      name='Launch Nautilus'
    '';
  };

  programs.dconf = {
    enable = true;

    profiles.user.databases = [{
      # lockAll = true; # prevents overriding
      settings = {
        # "org/gnome/desktop/interface" = {
        #   accent-color = "blue";
        # };
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer" # fractional scaling
            "xwayland-native-scaling" # sharper XWayland apps (GNOME 47+)
          ];
        };

        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "caps:swapescape" ];
        };

        "org/gnome/desktop/wm/keybindings" = {
          activate-window-menu = [ "<Super>space" ];
          close = [ "<Control>q" ];
          minimize = [ "" ];
          move-to-workspace-left = [ "<Shift><Super>comma" ];
          move-to-workspace-right = [ "<Shift><Super>period" ];
          switch-to-workspace-left = [ "<Super>comma" ];
          switch-to-workspace-right = [ "<Super>period" ];
          toggle-maximized = [ "<Super>m" ];
          toggle-message-tray = [ "<Super>v" ];
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
          dock-position = "LEFT";
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

        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        #   {
        #     binding = "<Super>e";
        #     command = "nautilus";
        #     name = "launch Nautilus";
        #   };
        #
        # #       /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding
        # #   '<Super>e'
        # # /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command
        # #   'nautilus'
        # # /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name
        # #   'launch Nautilus'
      };
    }];
  };

}

