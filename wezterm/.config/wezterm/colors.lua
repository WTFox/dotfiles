local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

local light = "jellybeans-light"
local dark = "jellybeans-mono"

return {
	color_scheme = utils.scheme_for_appearance(wezterm.gui.get_appearance(), dark, light),
	color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
