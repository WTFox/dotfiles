local Utils = require("utils")

local transparent_background = false
if Utils.is_wsl() then
  transparent_background = true
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
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
      color_overrides = {
        mocha = {
          base = "#11111b",
        },
        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-6410765
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
