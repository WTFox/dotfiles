return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>z",
      function()
        require("snacks").zen({
          enter = true,
          fixbuf = false,
          minimal = true,
          width = 120,
          height = 0,
          backdrop = { transparent = false },
          keys = { q = false },
          wo = {
            winhighlight = "NormalFloat:NONE",
          },
        })
      end,
    },
  },
}
