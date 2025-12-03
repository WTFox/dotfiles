local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}

local bg = "#101010"
local blue = "#6e94b2"
local yellow = "#f3be7c"
local purple = "#bb9dbd"

M.setup = function(config)
    local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
    tabline.setup({
        options = {
            icons_enabled = true,
            theme_overrides = {
                normal_mode = {
                    a = { fg = bg, bg = blue },
                    b = { fg = blue, bg = "#252530" },
                    c = { fg = "#aeaed1", bg = bg },
                },
                copy_mode = {
                    a = { fg = bg, bg = yellow },
                    b = { fg = yellow, bg = "#252530" },
                    c = { fg = "#aeaed1", bg = "#252530" },
                },
                search_mode = {
                    a = { fg = "#141415", bg = "#7fa563" },
                    b = { fg = "#7fa563", bg = "#252530" },
                    c = { fg = "#aeaed1", bg = "#252530" },
                },
                window_mode = {
                    a = { fg = bg, bg = "#bb9dbd" },
                    b = { fg = "#bb9dbd", bg = "#252530" },
                    c = { fg = "#cdcdcd", bg = "#252530" },
                },
                tab = {
                    active = { fg = bg, bg = yellow },
                    inactive = { fg = "#606079", bg = bg },
                    inactive_hover = { fg = "#d8647e", bg = "#252530" },
                },
            },
            section_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
            component_separators = {
                left = wezterm.nerdfonts.pl_left_soft_divider,
                right = wezterm.nerdfonts.pl_right_soft_divider,
            },
            tab_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
        },
        sections = {
            tabline_a = { "hostname" },
            tabline_b = {
                "workspace",
            },
            tabline_c = {
                -- " "
            },
            tab_active = {
                "index",
                { "process", padding = { right = 1 } },
                { "zoomed", padding = 0 },
            },
            tab_inactive = {
                "index",
                { "process", padding = { left = 0, right = 1 } },
            },
            tabline_x = {},
            tabline_y = {
                -- "ram",
                -- "cpu"
            },
            tabline_z = {
                { "datetime", style = "%H:%M" },
            },
        },
        extensions = { "presentation" },
    })

    -- specific tabline config
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = false
    config.hide_tab_bar_if_only_one_tab = false
    config.window_decorations = "NONE"

    tabline.apply_to_config(config)
end

return M
