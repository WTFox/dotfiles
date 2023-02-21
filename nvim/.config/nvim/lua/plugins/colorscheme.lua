return {
  { "catppuccin/nvim", lazy = true, name = "catppuccin" },
  -- update the definition of LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
