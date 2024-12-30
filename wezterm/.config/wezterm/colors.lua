local wezterm = require("wezterm") --[[@as Wezterm]]

local function scheme_for_appearance(appearance)
	return appearance:find("Light") and "jellybeans-light" or "jellybeans-dark"
end

return {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
