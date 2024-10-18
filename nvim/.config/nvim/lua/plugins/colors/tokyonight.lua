return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = { italic = false },
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    dim_inactive = true, -- dims inactive windows

    lualine_bold = true,
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    on_colors = function(colors)
      -- colors.border = colors.purple
      -- colors.bg = "#11111b"
      -- colors.bg = "#1b1b1f"
      -- colors.bg = "#0e0e13"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    on_highlights = function(hl, c)
      local prompt = "#2d3149"

      -- general ui
      hl.MiniIndentscopeSymbol = {
        fg = c.purple,
        nocombine = true,
      }

      -- material-looking telescope
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

      -- dashboard
      hl.DashboardIcon = {
        fg = c.orange,
      }
      hl.DashboardDesc = {
        fg = c.fg_dark,
      }
      hl.DashboardFooter = {
        fg = c.magenta,
      }

      -- lang-specific
      -- python
      hl["@string.documentation.python"] = {
        fg = c.comment,
      }
      hl["@lsp.typemod.function.defaultLibrary.python"] = {
        link = "@type.builtin",
      }

      -- json
      hl["@property.json"] = {
        fg = c.blue,
      }
      hl["@punctuation.bracket.json"] = {
        fg = c.comment,
      }
    end,
  },
}
