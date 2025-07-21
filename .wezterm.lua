-- Pull in the wezterm API
local wezterm = require("wezterm")

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

modal.apply_to_config(config)

-- local clickable = require("./wezterm/clickable_paths.lua")
-- clickable.apply_to_config(config)
--
-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.default_cursor_style = 'SteadyBar'
config.cursor_blink_rate = 0

-- Acceptable values are SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.

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
config.color_scheme = "tokyonight_night"
config.color_scheme = "Dracula"

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	-- font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
}

config.window_background_opacity = 0.8
-- timeout_milliseconds defaults to 1000 and can be omitted

config.inactive_pane_hsb = {
	saturation = 0.8, -- Reduce colorfulness
	brightness = 0.7, -- Dim the pane
}

config.colors = {
	-- split = "#444444", -- Color of split lines between panes
}

config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }

-- Disable native Wayland; use XWayland instead
config.enable_wayland = false
config.default_prog = { 'fish', '-l' }

config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitPane({ direction = "Left", size = { Percent = 50 } }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		-- -
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "f",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({
			confirm = false, -- ask for confirmation before closing the pane
		}),
	},
	{
		key = "x",
		mods = "LEADER|SHIFT",
		action = wezterm.action.CloseCurrentTab({
			confirm = false, -- ask for confirmation before closing the pane
		}),
	},
}

smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	direction_keys = { "h", "j", "k", "l" },
	-- if you want to use separate direction keys for move vs. resize, you
	-- can also do this:
	-- direction_keys = {
	-- 	move = { "h", "j", "k", "l" },
	-- 	resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	-- },
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
	-- log level to use: info, warn, error
	log_level = "info",
})
--
--

modal.set_default_keys(config)

-- Finally, return the configuration to wezterm:
return config
