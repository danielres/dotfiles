# hibernate.nix

{ pkgs, ... }:

{
  # logind advertises hibernate
  services.logind.extraConfig = ''
    HibernateMode=platform
    AllowHibernation=yes
  '';

  # polkit lets any user hibernate
  security.polkit.extraConfig = ''
    polkit.addRule(function(a, s) {
      if (a.id == "org.freedesktop.login1.hibernate"
          || a.id == "org.freedesktop.login1.hibernate-multiple-sessions")
        return polkit.Result.YES;
    });
  '';

  # extension package
  environment.systemPackages = with pkgs;
    [ gnomeExtensions.hibernate-status-button ];

  # dconf entry that turns the extension on
  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/shell".enabled-extensions =
      [ "hibernate-status-button@github.com" ];
  }];
}

