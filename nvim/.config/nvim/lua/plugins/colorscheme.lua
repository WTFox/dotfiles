return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      color_overrides = {
        -- mocha = {
        --   base = "#11111b",
        -- },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "night" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
