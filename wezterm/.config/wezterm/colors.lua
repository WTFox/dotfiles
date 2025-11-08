local utils = require("lib.utils")
local wezterm = require("wezterm") --[[@as Wezterm]]

local appearance = wezterm.gui.get_appearance()

---@type StrictConfig
return {
    color_scheme = utils.scheme_for_appearance(appearance, "vague", "catppuccin-latte"),
    color_scheme_dirs = { "~/.config/wezterm/colors/" },
}
