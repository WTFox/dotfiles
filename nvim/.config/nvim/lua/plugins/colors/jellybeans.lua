return {
  "wtfox/jellybeans.nvim",
  opts = {
    on_highlights = function(hl, c)
      -- TODO: borderless telescope

      -- local prompt = c.background
      -- hl.TelescopeNormal = {
      --   bg = c.mine_shaft,
      --   fg = c.background,
      -- }
      -- hl.TelescopeBorder = {
      --   bg = c.mine_shaft,
      --   fg = c.background,
      -- }
      -- hl.TelescopePromptNormal = {
      --   bg = prompt,
      -- }
      -- hl.TelescopePromptBorder = {
      --   bg = prompt,
      --   fg = prompt,
      -- }
      -- hl.TelescopePromptTitle = {
      --   bg = prompt,
      --   fg = prompt,
      -- }
      -- hl.TelescopePreviewTitle = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }
      -- hl.TelescopeResultsTitle = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }
    end,
  },
}
