---@diagnostic disable-next-line: unused-local,unused-function
local set_oled = function(c)
  c.background = vim.o.background == "dark" and "#000000" or c.background
end

return {
  -- "wtfox/jellybeans.nvim",
  dir = "~/dev/jellybeans.nvim",
  opts = {
    transparent = false,
    italics = false,
    style = "dark",
    flat_ui = true,
    palette = "jellybeans_muted",

    on_colors = function(c)
      -- set_oled(c)
      c.visual = vim.o.background == "dark" and c.zambezi or c.visual
    end,

    on_highlights = function(hl, c)
      -- example: change namespace colors to blue for golang
      --
      -- hl["@lsp.type.namespace.go"] = {
      --   fg = c.morning_glory,
      -- }

      hl.FloatTitle = {
        fg = c.morning_glory,
        bg = c.background,
      }

      hl.FloatBorder = {
        fg = c.tundora,
        bg = c.background,
      }

      hl.Pmenu = {
        bg = c.tundora,
      }

      hl.PmenuSbar = {
        bg = c.tundora,
        fg = c.zambezi,
      }
    end,
  },
}
