# mangowc.nix

{ pkgs, ... }:
{
  programs.mango.enable = true;

  security.pam.services.swaylock = { };

  programs.seahorse.enable = true;
  programs.dms-shell.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      # Let tuigreet use the display-manager session entry registered by MangoWC.
      command = "${pkgs.tuigreet}/bin/tuigreet --time --user-menu --remember-session --remember";
      user = "daniel";
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
