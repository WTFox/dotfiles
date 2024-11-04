local dark_theme = "kanagawa-dragon"
local light_theme = "kanagawa-light"

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
