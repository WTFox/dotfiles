local wezterm = require("wezterm")
local fonts = require("lib.fonts")

return {
	font_size = 16,
	font = wezterm.font(fonts.jetbrains_styled),
	adjust_window_size_when_changing_font_size = false,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.3,
	},
	custom_block_glyphs = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	default_cursor_style = "BlinkingBlock",
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_cols = 120,
	initial_rows = 32,
	-- window_background_opacity = 0.3
	-- macos_window_background_blur = 20
}
