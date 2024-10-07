-- local dark_theme = "catppuccin-macchiato"
local dark_theme = "catppuccin-mocha"
-- local dark_theme = "github_dark_default"
-- local dark_theme = "nordic"
-- local dark_theme = "obscure"
-- local dark_theme = "tokyonight-night"
-- local dark_theme = "vscode"
-- local dark_theme = "zenbones"
local light_theme = "zenbones"

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
  { import = "plugins.colors.ayu" },
  { import = "plugins.colors.catppuccin" },
  { import = "plugins.colors.darcula" },
  { import = "plugins.colors.github" },
  { import = "plugins.colors.kanagawa" },
  { import = "plugins.colors.obscure" },
  { import = "plugins.colors.nordic" },
  { import = "plugins.colors.tokyonight" },
  { import = "plugins.colors.vscode" },
  { import = "plugins.colors.zenbones" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = dark_theme,
    },
  },
}
