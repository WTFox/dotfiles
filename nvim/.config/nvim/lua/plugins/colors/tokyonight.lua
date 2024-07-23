---@module "tokyonight"

return {
  "folke/tokyonight.nvim",
  lazy = true,
  ---@type Config
  opts = {
    lualine_bold = true,
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    on_colors = function(colors)
      colors.border = colors.purple
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
