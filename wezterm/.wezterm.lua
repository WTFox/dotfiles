local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Functions
local function get_os()
	local os_name = wezterm.target_triple
	if os_name:find("windows") then
		return "windows"
	elseif os_name:find("darwin") then
		return "macos"
	else
		return "linux"
	end
end

-- Behavior
config.automatically_reload_config = true

-- UI
config.custom_block_glyphs = true
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

-- Font
config.font_size = 16.0
config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt=1",
		"clig=1",
		"liga=1",
		"zero=1",
		"ss02=1",
		"ss20=1",
		"cv03=1",
		"cv06=1",
		"cv15=1",
		"cv16=1",
		"cv18=1",
		"cv19=1",
	},
})

-- Shell
if get_os() == "windows" then
	config.default_program = { "WSL:Ubuntu" }
end

-- Colors
local catppuccin_mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin_mocha.background = "#11111b"
config.color_schemes = {
	["catppuccin-mocha"] = catppuccin_mocha,
}
config.color_scheme = "catppuccin-mocha"

-- Keys
config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action({ CopyTo = "Clipboard" }),
	},
	-- split vertical with ctrl-enter
	{
		key = "Enter",
		mods = "CTRL",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	-- split horizontal with ctrl-shift-enter
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- toggle pane zoom with shift-ctrl-l
	{
		key = "l",
		mods = "SHIFT|CTRL",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- switch panes with ctrl-shift-[ and ]
	{
		key = "[",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "]",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- unmap alt-enter
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
