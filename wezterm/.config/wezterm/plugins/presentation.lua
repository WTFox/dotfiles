local utils = require("lib.utils")
local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}

M.setup = function(config)
    local presentation = wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez")
    presentation.apply_to_config(config, {
        font_size_multiplier = 1.7, -- sets for both "presentation" and "presentation_full"
        presentation = {
            keybind = { key = "t", mods = "SHIFT|SUPER" }, -- setting a keybind
        },
        presentation_full = {
            keybind = { key = "t", mods = "CTRL|SHIFT|SUPER" }, -- setting a keybind
            font_weight = "Bold",
            font_size_multiplier = 2, -- overwrites "font_size_multiplier" for "presentation_full"
        },
    })
end

return M
