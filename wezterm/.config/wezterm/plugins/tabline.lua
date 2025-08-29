local wezterm = require("wezterm") --[[@as Wezterm]]
local colors = require("colors")

local M = {}

M.setup = function(config)
	local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
	tabline.setup({
		options = {
			icons_enabled = true,
			theme = colors.dark,
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
