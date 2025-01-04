return {
  "wtfox/jellybeans.nvim",
  -- dir = "~/dev/jellybeans.nvim",
  opts = {
    -- on_colors = function(c)
    --   local light_bg = "#ffffff"
    --   local dark_bg = "#000000"
    --   c.background = vim.o.background == "light" and light_bg or dark_bg
    -- end,

    on_highlights = function(hl, c)
      -- fix highlights in light-mode
      hl.Visual = { bg = vim.o.background == "light" and c.grey_one or hl.Visual.bg }
    end,
  },
}
