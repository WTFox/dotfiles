return {
  "wtfox/jellybeans.nvim",
  -- dir = "~/dev/jellybeans.nvim",
  opts = {
    italics = false,
    -- on_colors = function(c)
    -- end,

    on_highlights = function(hl, c)
      hl["@lsp.type.namespace.go"] = {
        fg = c.morning_glory,
      }
    end,
  },
}
