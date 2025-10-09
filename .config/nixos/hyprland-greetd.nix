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

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "daniel";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = { hyprland = { default = [ "hyprland" ]; }; };
  };

  hardware.graphics.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
