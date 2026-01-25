{ config, pkgs, ... }: {
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  networking.firewall = {
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
  };

  environment.systemPackages = [ pkgs.kdePackages.kdeconnect-kde ];
}

