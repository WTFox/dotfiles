local wezterm = require("wezterm")
local fonts = require("lib.fonts")

return {
	default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
	window_background_opacity = 0.9,
	-- win32_system_backdrop = "Tabbed",
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	},
}
