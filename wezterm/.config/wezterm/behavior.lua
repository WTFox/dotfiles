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
    term = "wezterm",
    hyperlink_rules = wezterm.default_hyperlink_rules(),
    automatically_reload_config = true,
    enable_kitty_keyboard = true,
    enable_csi_u_key_encoding = true,
}
