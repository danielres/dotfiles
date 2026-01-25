{ config, pkgs, ... }: {
  # KDE Connect daemon (user service) + tools
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdeconnect;
  };

  # mDNS discovery (usually required for pairing / auto-discovery)
  services.avahi = {
    enable = true;
    nssmdns4 = true; # or nssmdns = true; depending on your config style
    openFirewall = true;
  };

  # Open KDE Connect ports
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    }];
  };

  # Optional: GUI app (nice for pairing / status)
  environment.systemPackages = with pkgs; [ kdeconnect ];
}
