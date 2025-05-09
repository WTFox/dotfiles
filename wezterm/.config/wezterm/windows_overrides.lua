local wezterm = require("wezterm")
local fonts = require("lib.fonts")

return {
	font_size = 15,
	font = wezterm.font(fonts.jetbrains_styled),
	default_prog = { "wsl.exe", "~" },
	default_domain = "WSL:Ubuntu",
	-- window_background_opacity = 0.9,
	-- win32_system_backdrop = "Tabbed",
}
