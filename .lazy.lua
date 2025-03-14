return {
	-- show hidden files in neotree and snacks picker by default
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					grep = {
						hidden = true,
					},
					files = {
						hidden = true,
					},
					explorer = {
						hidden = true,
					},
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Library paths can be absolute
				-- "~/projects/my-awesome-lib",
				-- Or relative, which means they will be resolved from the plugin dir.
				"lazy.nvim",
				-- It can also be a table with trigger words / mods
				-- Only load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				-- always load the LazyVim library
				-- "LazyVim",
				-- Only load the lazyvim library when the `LazyVim` global is found
				{ path = "LazyVim", words = { "LazyVim" } },
				-- Load the wezterm types when the `wezterm` module is required
				-- Needs `justinsgithub/wezterm-types` to be installed
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
			-- always enable unless `vim.g.lazydev_enabled = false`
			-- This is the default
			-- enabled = function(root_dir)
			-- 	return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
			-- end,
			-- -- disable when a .luarc.json file is found
			-- enabled = function(root_dir)
			-- 	return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			-- end,
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{ "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
