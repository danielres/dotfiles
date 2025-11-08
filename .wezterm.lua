-- Pull in the wezterm API
local wezterm = require("wezterm")

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- ----- Core UI -----
config.window_close_confirmation = "NeverPrompt"
modal.apply_to_config(config)

config.initial_cols = 120
config.initial_rows = 28

config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0

config.font_size = 14

-- Tabs / frame
config.window_decorations = "NONE"
config.use_fancy_tab_bar = true
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {}

config.window_background_opacity = 1

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Leader & shell
config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }
config.enable_wayland = false
config.default_prog = { "fish", "-l" }

-- ----- Keymaps -----
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
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{ -- send ^A after <leader>^A (tmux muscle memory)
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
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "x",
		mods = "LEADER|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
}

-- ----- Smart splits -----
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "META",
	},
	log_level = "info",
})

modal.set_default_keys(config)

-- =================================================================
-- Darkened Catppuccin variant:
-- IMPORTANT: tab bar colors live under `config.colors.tab_bar`, not in the scheme.
-- =================================================================
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#1d1d28" -- OLED-deep background

config.color_schemes = config.color_schemes or {}
config.color_schemes["OLEDppuccin"] = custom
config.color_scheme = "OLEDppuccin"

-- Tab bar + optional split line color
config.colors = {
	split = "#303030",
	tab_bar = {
		background = "#040404",
		active_tab = {
			bg_color = "#1a1a1a",
			fg_color = "#c7c7c7",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0f0f0f",
			fg_color = "#8a8a8a",
		},
		inactive_tab_hover = {
			bg_color = "#121212",
			fg_color = "#c7c7c7",
			italic = true,
		},
		new_tab = {
			bg_color = "#080808",
			fg_color = "#8a8a8a",
		},
		new_tab_hover = {
			bg_color = "#101010",
			fg_color = "#c7c7c7",
			italic = true,
		},
	},
}

-- Finally, return the configuration to wezterm:
return config
