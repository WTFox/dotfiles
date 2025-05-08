local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}

local bg = "#101010"
-- local bg = "#000000"

M.setup = function(config)
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			icons_enabled = true,
			theme_overrides = {
				normal_mode = {
					a = { fg = bg, bg = "#83adc3" },
					b = { fg = "#83adc3", bg = "#1f1f1f" },
					c = { fg = "#c6b6ee", bg = bg },
				},
				copy_mode = {
					a = { fg = bg, bg = "#d8a16c" },
					b = { fg = "#d8a16c", bg = "#1f1f1f" },
					c = { fg = "#c6b6ee", bg = "#151515" },
				},
				search_mode = {
					a = { fg = "#000000", bg = "#d2ebbe" },
					b = { fg = "#d2ebbe", bg = "#313244" },
					c = { fg = "#c6b6ee", bg = "#151515" },
				},
				window_mode = {
					a = { fg = bg, bg = "#cba6f7" },
					b = { fg = "#cba6f7", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#181825" },
				},
				tab = {
					active = { fg = bg, bg = "#d8a16c" },
					inactive = { fg = "#cdd6f4", bg = bg },
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
			tabline_c = {
				-- " "
			},
			tab_active = {
				"index",
				-- { "parent", padding = 0 },
				-- "/",
				{ "cwd", padding = { left = 0, right = 1 } },
				{ "zoomed", padding = 0 },
			},
			tab_inactive = {
				"index",
				-- { "process", padding = { left = 0, right = 1 } },
				{ "cwd", padding = { left = 0, right = 1 } },
			},
			tabline_x = { "" },
			tabline_y = {
				"ram",
				"cpu",
				-- "datetime",
				"battery",
			},
			tabline_z = { "hostname" },
		},
		extensions = {},
	})

	-- specific tabline config
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false
	config.window_decorations = "NONE"

	tabline.apply_to_config(config)
end

return M
