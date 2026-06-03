{
  ...
}:
{
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  environment.etc."wireplumber/main.lua.d/51-audio-priority.lua".text = ''
    rule = {
      matches = {
        {
          { "node.name", "matches", "bluez_output.*" },
        },
      },
      apply_properties = {
        ["priority.session"] = 2000,
      },
    }
    table.insert(alsa_monitor.rules, rule)

    rule = {
      matches = {
        {
          { "node.name", "matches", "alsa_output.*hdmi.*" },
        },
      },
      apply_properties = {
        ["priority.session"] = 1500,
      },
    }
    table.insert(alsa_monitor.rules, rule)

    rule = {
      matches = {
        {
          { "node.name", "matches", "alsa_output.*analog.*" },
        },
      },
      apply_properties = {
        ["priority.session"] = 500,
      },
    }
    table.insert(alsa_monitor.rules, rule)
  '';
}
