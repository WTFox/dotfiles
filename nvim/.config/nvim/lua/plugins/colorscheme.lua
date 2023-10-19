return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      color_overrides = {
        mocha = {
          base = "#11111b",
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "night" },
  },
  {
    -- kanagawa
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      -- luacheck: ignore
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
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
