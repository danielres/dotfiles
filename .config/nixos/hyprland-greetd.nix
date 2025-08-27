# hyprland-greetd.nix

{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock = { enable = true; };

  # Allow hyprlock to authenticate
  security.pam.services.hyprlock = { };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "daniel";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  hardware.opengl.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
