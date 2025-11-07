local wezterm = require("wezterm") --[[@as Wezterm]]

-- use this to get the wezterm terminfo entry
-- https://wezterm.org/config/lua/config/term.html
--
-- $ tempfile=$(mktemp) \
--   && curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo \
--   && tic -x -o ~/.terminfo $tempfile \
--   && rm $tempfile

---@type StrictConfig
return {
    force_reverse_video_cursor = true,
    -- Use xterm-256color for SSH compatibility (remote servers have this terminfo)
    -- wezterm terminfo not available on most remote systems
    term = "xterm-256color",
    hyperlink_rules = wezterm.default_hyperlink_rules(),
    automatically_reload_config = false,
    enable_kitty_keyboard = true,
    enable_csi_u_key_encoding = true,

    -- Performance optimizations
    front_end = "WebGpu", -- Use Metal on macOS for best performance
    -- animation_fps = 1, -- Reduce animation overhead (default 10)
    -- max_fps = 120, -- Limit max frame rate
    scrollback_lines = 10000, -- Reasonable scrollback (default 3500)
    ssh_domains = wezterm.default_ssh_domains(),
}
