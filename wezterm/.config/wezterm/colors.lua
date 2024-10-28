local wezterm = require("wezterm") --[[@as Wezterm]]

DARK_THEME = "catppuccin-mocha-custom"
LIGHT_THEME = "Gruvbox light, hard (base16)"

local function scheme_for_appearance(appearance, dark, light)
	if appearance:find("Dark") then
		return dark
	end
	return light
end

return {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance(), DARK_THEME, LIGHT_THEME),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
