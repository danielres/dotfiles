{ ... }:

{
  services.home-assistant = {
    enable = true;

    # Keep the packaged integration available even when configured via the UI.
    extraComponents = [
      "analytics"
      "google_translate"
      "govee_light_local"
      "isal"
      "met"
      "radio_browser"
      "shopping_list"
    ];

    config = {
      default_config = { };
    };
  };

  networking.firewall.allowedUDPPorts = [
    # 4002 for home-assistant
    4002
  ];
}
