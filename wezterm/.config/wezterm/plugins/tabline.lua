local wezterm = require("wezterm") --[[@as Wezterm]]

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = true,
		color_overrides = {
			normal_mode = {
				a = { fg = "#181825", bg = "#8fbfdc" },
				b = { fg = "#b0d0f0", bg = "#1f1f1f" },
				c = { fg = "#c6b6ee", bg = "#151515" },
			},
			copy_mode = {
				a = { fg = "#181825", bg = "#fad07a" },
				b = { fg = "#fad07a", bg = "#1f1f1f" },
				c = { fg = "#c6b6ee", bg = "#151515" },
			},
			search_mode = {
				a = { fg = "#181825", bg = "#d2ebbe" },
				b = { fg = "#d2ebbe", bg = "#313244" },
				c = { fg = "#c6b6ee", bg = "#151515" },
			},
			window_mode = {
				a = { fg = "#181825", bg = "#cba6f7" },
				b = { fg = "#cba6f7", bg = "#313244" },
				c = { fg = "#cdd6f4", bg = "#181825" },
			},
			tab = {
				active = { fg = "#1f1f1f", bg = "#e6a75a" },
				inactive = { fg = "#cdd6f4", bg = "#151515" },
				inactive_hover = { fg = "#f5c2e7", bg = "#181825" },
			},
		},
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

return tabline
