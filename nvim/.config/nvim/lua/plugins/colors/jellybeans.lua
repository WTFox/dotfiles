---@diagnostic disable-next-line: unused-local,unused-function
local set_oled = function(c)
  c.background = vim.o.background == "dark" and "#000000" or c.background
end

return {
  "wtfox/jellybeans.nvim",
  branch = "replace-autocmd",
  dev = true,
  opts = {
    transparent = false,
    italics = true,
    flat_ui = false,
    background = {
      dark = "jellybeans_muted",
      light = "jellybeans_muted_light",
    },

    on_colors = function(c)
      -- set_oled(c)
      -- c.visual = vim.o.background == "dark" and c.zambezi or c.visual
    end,

    on_highlights = function(hl, c)
      -- example: change namespace colors to blue for golang
      --
      -- hl["@lsp.type.namespace.go"] = {
      --   fg = c.morning_glory,
      -- }

      -- hl.InclineNormal = {
      --   fg = c.alto,
      -- }

      -- local color = "#11111b"
      -- hl.TreesitterContext = { bg = color }
      -- hl.TreesitterContextLineNumber = { bg = color }
      -- hl.TreesitterContextBottom = {
      --   underline = false,
      --   sp = color,
      -- }
    end,
  },
}
