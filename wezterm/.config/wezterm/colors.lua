local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

local light = "jellybeans-muted-light"
local dark = "jellybeans-muted"

return {
    color_scheme = utils.scheme_for_appearance(wezterm.gui.get_appearance(), dark, light),
    color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
