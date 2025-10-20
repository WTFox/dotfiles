local fonts = require("lib.fonts")
local wezterm = require("wezterm") --[[@as Wezterm]]

---@type StrictConfig
return {
    font_size = 16,
    -- line_height = 1.1,
    font = wezterm.font_with_fallback({
        -- fonts.mononoki,
        -- fonts.monolisa,
        -- fonts.cascadia_code,
        fonts.jetbrains,
        fonts.jetbrains_styled,
    }),
    adjust_window_size_when_changing_font_size = false,
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 500, -- Optimize blink rate (ms)
    initial_cols = 114,
    initial_rows = 31,
    bold_brightens_ansi_colors = true,
    window_decorations = "RESIZE|INTEGRATED_BUTTONS",
    window_background_opacity = 0.9,
    macos_window_background_blur = 95,

    -- Remove window padding to eliminate empty space at bottom
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    -- macOS fullscreen behavior
    native_macos_fullscreen_mode = false, -- Keep fast toggle
    macos_fullscreen_extend_behind_notch = true, -- Extend behind notch for cleaner look
}
