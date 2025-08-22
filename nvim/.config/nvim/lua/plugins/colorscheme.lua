return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
      end,
    },
  },
  { import = "plugins.colors.catppuccin" },
  { import = "plugins.colors.gruvbox" },
  { import = "plugins.colors.jellybeans" },
  { import = "plugins.colors.kanagawa" },
  { import = "plugins.colors.tokyonight" },
  { import = "plugins.colors.vague" },
  { import = "plugins.colors.zenbones" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vague",
    },
  },
}
