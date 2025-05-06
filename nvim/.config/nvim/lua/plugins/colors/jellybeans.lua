---@diagnostic disable-next-line: unused-local,unused-function
local set_oled = function(c)
  c.background = vim.o.background == "dark" and "#000000" or c.background
end

return {
  "wtfox/jellybeans.nvim",
  -- dir = "~/dev/jellybeans.nvim",
  opts = {
    transparent = false,
    italics = true,
    style = "dark",
    flat_ui = false,
    palette = "jellybeans_muted",

    on_colors = function(c)
      set_oled(c)
      c.visual = vim.o.background == "dark" and c.zambezi or c.visual
    end,

    on_highlights = function(hl, c)
      -- example: change namespace colors to blue for golang
      --
      -- hl["@lsp.type.namespace.go"] = {
      --   fg = c.morning_glory,
      -- }

      hl["Comment"] = { fg = "#444444" }

      hl.InclineNormal = {
        fg = c.alto,
      }

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
