local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

-- local light = "jellybeans-muted-light"
local light = "Gruvbox (Gogh)"
local dark = "GruvboxDarkHard"

return {
	light = light,
	dark = dark,
	color_scheme = utils.scheme_for_appearance(wezterm.gui.get_appearance(), dark, light),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
