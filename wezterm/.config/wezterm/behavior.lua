local wezterm = require("wezterm") --[[@as Wezterm]]

---@type StrictConfig
return {
    hyperlink_rules = wezterm.default_hyperlink_rules(),
    automatically_reload_config = true,
    enable_kitty_keyboard = true,
    enable_csi_u_key_encoding = true,
}
