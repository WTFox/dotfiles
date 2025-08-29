local wezterm = require("wezterm")
local fonts = require("lib.fonts")
local colors = require("colors")

return {
	font_size = 15,
	line_height = 1,
	-- font = wezterm.font(fonts.jetbrains_styled),
	default_prog = { "wsl.exe", "~" },
	default_domain = "WSL:Ubuntu",
	color_scheme = colors.dark,
	-- window_background_opacity = 0.9,
	-- win32_system_backdrop = "Tabbed",
}
