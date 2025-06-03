local wezterm = require("wezterm") --[[@as Wezterm]]
local fonts = require("lib.fonts")

return {
	font_size = 17,
	font = wezterm.font_with_fallback({
		-- fonts.mononoki,
		fonts.jetbrains,
		fonts.jetbrains_styled,
	}),
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	default_cursor_style = "BlinkingBlock",
	initial_cols = 130,
	initial_rows = 32,
	bold_brightens_ansi_colors = true,
	window_decorations = "RESIZE|INTEGRATED_BUTTONS",
	-- window_background_opacity = 0.8,
	-- macos_window_background_blur = 80,
}
