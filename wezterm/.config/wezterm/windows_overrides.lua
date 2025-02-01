local wezterm = require("wezterm")
local fonts = require("lib.fonts")

return {
	default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	},
}
