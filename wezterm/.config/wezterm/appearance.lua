local wezterm = require("wezterm") --[[@as Wezterm]]
local fonts = require("lib.fonts")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Catppuccin Mocha",
		color_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"tab_index",
			-- { "parent", padding = 0 },
			-- "/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {
			"tab_index",
			-- { "process", padding = { left = 0, right = 1 } },
			{ "cwd", padding = { left = 0, right = 1 } },
		},
		tabline_x = { "" },
		tabline_y = {
			"ram",
			"cpu",
			-- "datetime",
			-- "battery"
		},
		tabline_z = { "hostname" },
	},
	extensions = {},
})

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
	hide_tab_bar_if_only_one_tab = false,
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
