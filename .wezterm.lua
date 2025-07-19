-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = "Gruvbox dark, hard (base16)"
config.color_scheme = "Black Metal (base16)"
config.color_scheme = "Black Metal (Nile) (base16)"
config.color_scheme = "Batman"
config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme = "GruvboxDarkHard"
config.color_scheme = "Gruber (base16)"
config.color_scheme = "N0tch2k"
config.color_scheme = "Nord (Gogh)"
config.color_scheme = "Dracula"

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- Disable native Wayland; use XWayland instead
config.enable_wayland = false
config.default_prog = { 'fish', '-l' }

-- Finally, return the configuration to wezterm:
return config
