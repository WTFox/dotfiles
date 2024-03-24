local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_domain = "WSL:Ubuntu"
config.color_scheme = "catppuccin-mocha"

config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt=1",
		"clig=1",
		"liga=1",
		"zero=1",
		"ss02=1",
		"ss20=1",
		"cv03=1",
		"cv06=1",
		"cv15=1",
		"cv16=1",
		"cv18=1",
		"cv19=1",
	},
})

config.font_size = 13.0
config.custom_block_glyphs = true
config.colors = {
	background = "#11111b",
}
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
return config
