local Utils = require("utils")

local transparent_background = false
if Utils.is_wsl() or Utils.wants_transparent_background() then
  transparent_background = true
end

local light_theme = "rose-pine-dawn"
local dark_theme = "catppuccin-mocha"

return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme " .. dark_theme)
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
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
    "rebelot/kanagawa.nvim",
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
      colors = {
        theme = {
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
          DashboardHeader = { fg = theme.ui.special, bold = true },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          WinSeparator = { fg = theme.ui.fg_dim },
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
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      highlight_groups = {
        TelescopeBorder = { fg = "overlay", bg = "overlay" },
        TelescopeNormal = { fg = "subtle", bg = "overlay" },
        TelescopeSelection = { fg = "text", bg = "highlight_med" },
        TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
        TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

        TelescopeTitle = { fg = "base", bg = "love" },
        TelescopePromptTitle = { fg = "base", bg = "pine" },
        TelescopePreviewTitle = { fg = "base", bg = "iris" },

        TelescopePromptNormal = { fg = "text", bg = "surface" },
        TelescopePromptBorder = { fg = "surface", bg = "surface" },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = dark_theme,
    },
  },
}
