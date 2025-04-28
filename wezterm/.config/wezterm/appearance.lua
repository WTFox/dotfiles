local wezterm = require("wezterm") --[[@as Wezterm]]
local fonts = require("lib.fonts")

return {
	font_size = 16,
	font = wezterm.font(fonts.jetbrains),
	adjust_window_size_when_changing_font_size = false,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.3,
	},
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	default_cursor_style = "BlinkingBlock",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_cols = 130,
	initial_rows = 30,
	bold_brightens_ansi_colors = true,
	window_decorations = "RESIZE|INTEGRATED_BUTTONS",
	-- window_background_opacity = 0.8,
	-- macos_window_background_blur = 80,
}
