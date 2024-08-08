return {
  "AlexvZyl/nordic.nvim",
  opts = {
    -- This callback can be used to override the colors used in the palette.
    on_palette = function(palette)
      return palette
    end,
    -- Enable bold keywords.
    bold_keywords = true,
    -- Enable italic comments.
    italic_comments = true,
    -- Enable general editor background transparency.
    transparent_bg = false,
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark background with the normal one.
    swap_backgrounds = true,
    -- Override the styling of any highlight group.
    override = {
      -- native
      Pmenu = { bg = "#2E3440" },
      NormalFloat = { bg = "#2E3440" },
      DiagnosticVirtualTextError = { bg = "#1E222A" },
      DiagnosticVirtualTextWarn = { bg = "#1E222A" },
      -- dashboard-nvim
      DashboardHeader = { fg = "#d79784" },
      DashboardIcon = { fg = "#d79784" },
      DashboardKey = { fg = "#d79784" },
      DashboardDesc = { fg = "#81A1C1" },
      -- incline
      InclineNormal = { bg = "#191D24" },
      -- Lazygit
      LazyNormal = { bg = "#191D24" },
      -- NeoTree
      NeoTreeTitleBar = { fg = "#d79784", bg = "#1E222A" },
      NeoTreeFloatBorder = { bg = "#1E222A", fg = "#1E222A" },
      NvimTreeNormal = { bg = "#191D24" },
      NeoTreeFileName = { bg = "#191D24" },
      NvimTreeCursorLine = { bg = "#2e3440" },
      NvimTreeCursor = { bg = "NONE", fg = "NONE" },
      -- Telescope
      TelescopeNormal = { bg = "#191D24", fg = "#191D24" },
      TelescopePromptNormal = { bg = "#191D24" },
      TelescopePromptBorder = { fg = "#191D24", bg = "#191D24" },
      TelescopePromptTitle = { fg = "#191D24", bold = true },
      TelescopePromptPrefix = { fg = "#191D24", bg = "#191D24" },
      TelescopeResultsNormal = { bg = "#191D24" },
      TelescopeResultsBorder = { bg = "#191D24", fg = "#191D24" },
      TelescopePreviewNormal = { bg = "#191D24" },
      TelescopePreviewBorder = { bg = "#191D24", fg = "#191D24" },
      -- Treesitter
      -- ["@variable.parameter"] = { italic = true, fg = "#60728A" },
      ["@variable.parameter"] = { italic = true, fg = "#BE9DB8" },
      ["@lsp.type.parameter.python"] = { italic = true, fg = "#BE9DB8" },
      -- WhichKey
      WhichKeyNormal = { bg = "#191D24" },
    },
    -- Cursorline options.  Also includes visual/selection.
    -- cursorline = {
    --   -- Bold font in cursorline.
    --   bold = false,
    --   -- Bold cursorline number.
    --   bold_number = true,
    --   -- Available styles: 'dark', 'light'.
    --   theme = "dark",
    --   -- Blending the cursorline bg with the buffer bg.
    --   blend = 0.85,
    -- },
    cursorline = {
      theme = "light",
      blend = 1,
    },
    noice = {
      -- Available styles: `classic`, `flat`.
      style = "flat",
    },
    telescope = {
      -- Available styles: `classic`, `flat`.
      style = "flat",
    },
    leap = {
      -- Dims the backdrop when using leap.
      dim_backdrop = true,
    },
    ts_context = {
      -- Enables dark background for treesitter-context window
      dark_background = true,
    },
  },
}
