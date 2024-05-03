return {
	-- disable auto theme switching
	{
		"f-person/auto-dark-mode.nvim",
		enabled = false,
	},
	-- different colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "habamax",
		},
	},
	-- show hidden files in neotree by default
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignore = false,
					hide_hidden = false,
				},
			},
		},
	},
}
