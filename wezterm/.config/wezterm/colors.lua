local wezterm = require("wezterm")

local DARK_THEME = "catppuccin-mocha"
local LIGHT_THEME = "zenbones"

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return DARK_THEME
	end
	return LIGHT_THEME
end

local colors = wezterm.color.get_builtin_schemes()
local function set_theme_attr(theme, attr, value)
	local t = colors[theme]
	t[attr] = value
	config.color_schemes = {
		[theme] = t,
	}
end

return {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
