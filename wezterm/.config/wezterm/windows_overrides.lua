local wezterm = require("wezterm")

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

if is_windows then
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
end

return {}
