local Utils = require("utils")

local transparent_background = false
if Utils.is_wsl() or Utils.wants_transparent_background() then
  transparent_background = true
end

-- local dark_theme = "catppuccin-mocha"
local dark_theme = "tokyobones"
local light_theme = "zenbones"

local function switch_colorscheme()
  if vim.o.background == "dark" then
    vim.cmd("colorscheme " .. dark_theme)
  else
    vim.cmd("colorscheme " .. light_theme)
  end
end

-- Switch colorscheme based on the background option
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = switch_colorscheme,
})

vim.g.tokyobones = { darkness = "stark" }
vim.g.zenbones = { lightness = "bright" }

return {
  {
    -- follows the system theme
    "f-person/auto-dark-mode.nvim",
    config = {
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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- no_italic = true,
      -- no_bold = true,
      -- no_underline = true,
      transparent_background = transparent_background,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      background = {
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.pink },
          -- DiffChange = { fg = colors.base, bg = colors.pink },
        }
      end,
      color_overrides = {
        mocha = {
          base = "#11111b",
        },
        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-5287724
        frappe = {
          rosewater = "#ea6962",
          flamingo = "#ea6962",
          red = "#ea6962",
          maroon = "#ea6962",
          pink = "#d3869b",
          mauve = "#d3869b",
          peach = "#e78a4e",
          yellow = "#d8a657",
          green = "#a9b665",
          teal = "#89b482",
          sky = "#89b482",
          sapphire = "#89b482",
          blue = "#7daea3",
          lavender = "#7daea3",
          text = "#ebdbb2",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",
          overlay2 = "#a89984",
          overlay1 = "#928374",
          overlay0 = "#595959",
          surface2 = "#4d4d4d",
          surface1 = "#404040",
          surface0 = "#292929",
          base = "#1d2021",
          mantle = "#191b1c",
          crust = "#141617",
        },
        latte = {
          rosewater = "#c14a4a",
          flamingo = "#c14a4a",
          red = "#c14a4a",
          maroon = "#c14a4a",
          pink = "#945e80",
          mauve = "#945e80",
          peach = "#c35e0a",
          yellow = "#b47109",
          green = "#6c782e",
          teal = "#4c7a5d",
          sky = "#4c7a5d",
          sapphire = "#4c7a5d",
          blue = "#45707a",
          lavender = "#45707a",
          text = "#654735",
          subtext1 = "#73503c",
          subtext0 = "#805942",
          overlay2 = "#8c6249",
          overlay1 = "#8c856d",
          overlay0 = "#a69d81",
          surface2 = "#bfb695",
          surface1 = "#d1c7a3",
          surface0 = "#e3dec3",
          base = "#f9f5d7",
          mantle = "#f0ebce",
          crust = "#e8e3c8",
        },
      },
    },
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = dark_theme,
    },
  },
}
