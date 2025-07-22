local wezterm = require("wezterm") --[[@as Wezterm]]

local light = "jellybeans-muted-light"
local dark = "GruvboxDarkHard"

local function scheme_for_appearance(appearance)
	return appearance:find("Light") and light or dark
end

return {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
