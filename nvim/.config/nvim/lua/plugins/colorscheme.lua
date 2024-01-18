return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
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
        -- mocha = {
        --   rosewater = "#ffc9c9",
        --   flamingo = "#ff9f9a",
        --   pink = "#ffa9c9",
        --   mauve = "#df95cf",
        --   lavender = "#a990c9",
        --   red = "#ff6960",
        --   maroon = "#f98080",
        --   peach = "#f9905f",
        --   yellow = "#f9bd69",
        --   green = "#b0d080",
        --   teal = "#a0dfa0",
        --   sky = "#a0d0c0",
        --   sapphire = "#95b9d0",
        --   blue = "#89a0e0",
        --   text = "#e0d0b0",
        --   subtext1 = "#d5c4a1",
        --   subtext0 = "#bdae93",
        --   overlay2 = "#928374",
        --   overlay1 = "#7c6f64",
        --   overlay0 = "#665c54",
        --   surface2 = "#504844",
        --   surface1 = "#3a3634",
        --   surface0 = "#252525",
        --   base = "#151515",
        --   mantle = "#0e0e0e",
        --   crust = "#080808",
        -- },
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
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "night" },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false, -- enable compiling the colorscheme
      undercurl = false, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
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
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
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
