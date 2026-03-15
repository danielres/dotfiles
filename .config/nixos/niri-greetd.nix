# niri-greetd.nix

{ pkgs, ... }:
{
  programs.niri.enable = true;

  security.pam.services.swaylock = { };

  programs.seahorse.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        "${pkgs.tuigreet}/bin/tuigreet --time --user-menu --remember-session --remember --cmd niri-session";
      user = "daniel";
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
