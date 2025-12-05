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
    max_fps = 120,
    force_reverse_video_cursor = true,
    term = "xterm-256color",
    hyperlink_rules = wezterm.default_hyperlink_rules(),
    automatically_reload_config = false,
    enable_kitty_keyboard = true,
    enable_csi_u_key_encoding = true,
    front_end = "WebGpu",
    scrollback_lines = 10000,
    ssh_domains = wezterm.default_ssh_domains(),
    -- Ensure Alt key combinations work properly, especially over SSH
    -- Use CSI encoding for better compatibility with tmux/readline
    send_composed_key_when_alt_is_pressed = true,
}
