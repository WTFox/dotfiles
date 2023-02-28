return {
  -- installed themes go here
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
    lazy = false,
  },
  { "lunarvim/darkplus.nvim" },
  { "catppuccin/nvim", lazy = true, name = "catppuccin" },

  -- instruct vim to use the colorscheme we prefer
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
