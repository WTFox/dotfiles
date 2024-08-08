return {
  "AlexvZyl/nordic.nvim",
  branch = "dev",
  opts = {
    -- Enable bold keywords.
    bold_keywords = true,
    -- Enable italic comments.
    italic_comments = true,
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark bkackground with the normal one.
    swap_backgrounds = true,
    -- This callback can be used to override the colors used in the base palette.
    on_palette = function(palette) end,
    -- This callback can be used to override the colors used in the extended palette.
    after_palette = function(palette)
      -- palette.bg = palette.black1
      return palette
    end,
    on_highlight = function(highlights, palette)
      highlights.NoiceCmdlinePopup = {
        bg = palette.black0,
      }
      highlights.NoiceCmdlinePopupBorder = {
        bg = palette.black0,
        fg = palette.black0,
      }
      highlights.NoicePopupBorder = {
        fg = palette.black1,
      }
      highlights.Pmenu = {
        bg = palette.gray1,
      }
      highlights.NormalFloat = {
        bg = palette.gray1,
      }
      highlights.DiagnosticVirtualTextHint = {
        bg = palette.bg,
        fg = highlights.DiagnosticHint.fg,
      }
      highlights.DiagnosticVirtualTextWarn = {
        bg = palette.bg,
        fg = highlights.DiagnosticWarn.fg,
      }
      highlights.DiagnosticVirtualTextError = {
        bg = palette.bg,
        fg = highlights.DiagnosticError.fg,
      }
      highlights.DashboardHeader = {
        fg = palette.orange.bright,
      }
      highlights.DashboardIcon = {
        fg = palette.orange.bright,
      }
      highlights.DashboardKey = {
        fg = palette.orange.bright,
      }
      highlights.DashboardDesc = {
        fg = palette.blue1,
      }
      highlights.InclineNormal = {
        bg = palette.black1,
      }
      highlights.LazyNormal = {
        bg = palette.black0,
      }
      highlights.NeoTreeTitleBar = {
        fg = palette.orange.bright,
        bg = palette.black1,
      }
      highlights.NeoTreeFloatBorder = {
        bg = palette.black1,
        fg = palette.black1,
      }
      highlights.NvimTreeNormal = {
        bg = palette.black0,
      }
      highlights.NeoTreeFileName = {
        bg = palette.black0,
      }
      highlights.WinSeparator = {
        fg = palette.black1,
      }
      highlights.NeoTreeWinSeparator = {
        fg = palette.black1,
      }
      highlights.NvimTreeCursorLine = {
        bg = palette.gray1,
      }
      highlights.NvimTreeCursor = {
        bg = "NONE",
        fg = "NONE",
      }
      highlights.TelescopeNormal = {
        bg = palette.black0,
        fg = palette.black0,
      }
      highlights.TelescopePromptNormal = {
        bg = palette.black0,
      }
      highlights.TelescopePromptBorder = {
        fg = palette.black0,
        bg = palette.black0,
      }
      highlights.TelescopePromptTitle = {
        fg = palette.black0,
        bg = palette.magenta.bright,
        bold = true,
      }
      highlights.TelescopePromptPrefix = {
        fg = palette.black0,
        bg = palette.black0,
      }
      highlights.TelescopeResultsNormal = {
        bg = palette.black0,
      }
      highlights.TelescopeResultsBorder = {
        bg = palette.black0,
        fg = palette.black0,
      }
      highlights.TelescopePreviewNormal = {
        bg = palette.black0,
      }
      highlights.TelescopePreviewBorder = {
        bg = palette.black0,
        fg = palette.black0,
      }
      highlights["@variable.parameter"] = {
        italic = true,
        fg = palette.blue2,
      }
      highlights["@lsp.type.parameter.python"] = {
        italic = true,
        fg = palette.blue2,
      }
      highlights["@variable.parameter"] = {
        italic = true,
        fg = palette.blue2,
      }
      highlights.WhichKeyNormal = {
        bg = palette.black0,
      }
      return highlights, palette
    end,
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
      -- Bold font in cursorline.
      bold = false,
      -- Bold cursorline number.
      bold_number = true,
      -- Available styles: 'dark', 'light'.
      theme = "light",
      -- Blending the cursorline bg with the buffer bg.
      blend = 0.9,
    },
    noice = {
      style = "flat", -- Available styles: `classic`, `flat`.
    },
    telescope = {
      style = "flat", -- Available styles: `classic`, `flat`.
    },
    leap = {
      dim_backdrop = true,
    },
    ts_context = {
      dark_background = true,
    },
  },
}
