return {
  "wtfox/jellybeans.nvim",
  opts = {
    on_highlights = function(hl, c)
      hl.WinSeparator = {
        fg = c.grey_one,
      }
    end,
  },
}
