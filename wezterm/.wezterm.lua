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

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "catppuccin-mocha"
	else
		return "solarized-light"
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
config.font_size = 16
config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt=1",
		"clig=1",
		"liga=1",
		"zero=1",
		-- "ss01=1",
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

local solarized_light = wezterm.color.get_builtin_schemes()["Solarized Light (Gogh)"]
solarized_light.background = "#faf5d4"
config.color_schemes["solarized-light"] = solarized_light

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Keys
config.keys = {
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
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
	-- toggle pane zoom with shift-ctrl-l also works with shift-ctrl-z
	-- {
	-- 	key = "l",
	-- 	mods = "SHIFT|CTRL",
	-- 	action = wezterm.action.TogglePaneZoomState,
	-- },
	-- unmap alt-enter
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- map pane switching to super-hjkl
	{
		key = "h",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "j",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "l",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	-- toggle fullscreen with super-enter
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
