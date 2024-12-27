-- local dark_theme = "kanagawa-wave"
local dark_theme = "catppuccin-mocha"
-- local dark_theme = "jellybeans"
-- local dark_theme = "obscure"
-- local dark_theme = "tokyonight-night"
-- local dark_theme = "rose-pine"
local light_theme = "zenbones"
-- local light_theme = "catppuccin-latte"

-- Switch colorscheme based on the background option
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.o.background == "dark" then
      vim.cmd("colorscheme " .. dark_theme)
    else
      vim.cmd("colorscheme " .. light_theme)
    end
  end,
})

return {
  {
    -- follows the system theme
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme " .. dark_theme)
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme " .. light_theme)
      end,
    },
  },
  { import = "plugins.colors.catppuccin" },
  { import = "plugins.colors.jellybeans" },
  { import = "plugins.colors.kanagawa" },
  { import = "plugins.colors.tokyonight" },
  { import = "plugins.colors.zenbones" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = dark_theme,
    },
  },
}
