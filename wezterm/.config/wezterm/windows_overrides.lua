local wezterm = require("wezterm")
local fonts = require("lib.fonts")

return {
	font = wezterm.font(fonts.cascadia_code),
	default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
	tab_bar_at_bottom = true,
	font_size = 15,
	line_height = 1,
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	},
}
