return {
  "killitar/obscure.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    terminal_colors = true,
    dim_inactive = true,
    styles = {
      keywords = { italic = true },
      identifiers = {},
      functions = {},
      variables = {},
      booleans = {},
      comments = { italic = true },
    },

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    on_highlights = function(highlights, colors) end,

    plugins = {
      -- enable all plugins when not using lazy.nvim
      -- set to false to manually enable/disable plugins
      all = package.loaded.lazy == nil,
      -- uses your plugin manager to automatically enable needed plugins
      -- currently only lazy.nvim is supported
      auto = true,
      -- add any plugins here that you want to enable
      -- for all possible plugins, see:
      --   * https://github.com/killitar/obscure.nvim/tree/main/lua/obscure/groups
      -- flash = true,
    },
  },
}
