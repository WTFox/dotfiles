local fonts = require("lib.fonts")
local wezterm = require("wezterm") --[[@as Wezterm]]

---@type StrictConfig
return {
    font = wezterm.font(fonts.berkeley_mono),
    font_size = 15.0,
    adjust_window_size_when_changing_font_size = false,
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 1000,
    initial_cols = 136,
    initial_rows = 35,
    bold_brightens_ansi_colors = true,
    window_decorations = "RESIZE|INTEGRATED_BUTTONS",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    native_macos_fullscreen_mode = false, -- Keep fast toggle
    macos_fullscreen_extend_behind_notch = true, -- Extend behind notch for cleaner look
    -- window_background_opacity = 0.9,
    -- macos_window_background_blur = 95,
}
