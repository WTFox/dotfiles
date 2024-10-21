local wezterm = require("wezterm") --[[@as Wezterm]]

wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez").setup({
	options = {
		icons_enabled = true,
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
		tabline_b = {
			"workspace",
		},
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
