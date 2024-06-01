local Utils = require("utils")

local transparent_background = false
if Utils.is_wsl() or Utils.wants_transparent_background() then
  transparent_background = true
end

local dark_theme = "tokyonight-night"
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
        diffview = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        mini = {
          enabled = true,
          indentscope_color = "peach", -- catppuccin color (eg. `lavender`) Default: text
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
        macchiato = {
          rosewater = "#ffc9c9",
          flamingo = "#ff9f9a",
          pink = "#ffa9c9",
          mauve = "#df95cf",
          lavender = "#a990c9",
          red = "#ff6960",
          maroon = "#f98080",
          peach = "#f9905f",
          yellow = "#f9bd69",
          green = "#b0d080",
          teal = "#a0dfa0",
          sky = "#a0d0c0",
          sapphire = "#95b9d0",
          blue = "#89a0e0",
          text = "#e0d0b0",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",
          overlay2 = "#928374",
          overlay1 = "#7c6f64",
          overlay0 = "#665c54",
          surface2 = "#504844",
          surface1 = "#3a3634",
          surface0 = "#252525",
          base = "#151515",
          mantle = "#0e0e0e",
          crust = "#080808",
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      lualine_bold = true,

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.border = colors.purple
        -- colors.bg = "#11111b"
        colors.bg = "#0e0e13"
      end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param hl Highlights
      ---@param c ColorScheme
      on_highlights = function(hl, c)
        -- FIXME: override string.documentation to look like strings
        local prompt = "#2d3149"
        -- hl.Type = {
        --   fg = "#EA9999",
        -- }
        -- hl.Special = {
        --   fg = "#EA9999",
        -- }
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.DashboardIcon = {
          fg = c.orange,
        }
        hl.DashboardDesc = {
          fg = c.fg_dark,
        }
        hl.DashboardFooter = {
          fg = c.magenta,
        }
        hl["@string.documentation.python"] = {
          fg = c.comment,
        }
      end,
    },
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "Mofiqul/vscode.nvim",
    opts = {
      underline_links = true,
      italic_comments = true,
      disable_nvimtree_bg = true,
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
      colors = { -- add/modify theme and palette colors
        palette = {},
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
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          DashboardHeader = { fg = theme.ui.special },
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
      colorscheme = dark_theme,
    },
  },
}
