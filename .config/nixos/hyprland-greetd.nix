# hyprland-greetd.nix

{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  programs.hyprlock = { enable = true; };

  # Allow hyprlock to authenticate
  security.pam.services.hyprlock = { };

  # Keyring --------
  programs.seahorse.enable = true; # GUI to inspect/change keyrings
  # Start gnome keyring via PAM
  # - for greetd/tuigreet on Hyprland:
  security.pam.services.greetd.enableGnomeKeyring = true;
  # - always enable for the generic login service too:
  security.pam.services.login.enableGnomeKeyring = true;
  # ----------------

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        "${pkgs.tuigreet}/bin/tuigreet --time --user-menu --remember-session --remember --cmd Hyprland";
      user = "daniel";
    };
  };

  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    extraPortals = [
      ## 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    config = { hyprland = { default = [ "hyprland" ]; }; };
  };

  hardware.graphics.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
