return {
  "wtfox/jellybeans.nvim",
  -- dir = "~/dev/jellybeans.nvim",
  opts = {
    transparent = true,
    italics = true,
    style = "dark",
    flat_ui = true,

    on_colors = function(c)
      -- local light_bg = "#ffffff"
      -- local dark_bg = "#000000"
      -- c.background = vim.o.background == "light" and light_bg or dark_bg
    end,

    on_highlights = function(hl, c)
      -- change namespace colors to blue for golang
      -- hl["@lsp.type.namespace.go"] = {
      --   fg = c.morning_glory,
      -- }
    end,
  },
}
