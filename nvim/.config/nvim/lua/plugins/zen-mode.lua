return {
  "folke/zen-mode.nvim",
  dependencies = {
    "folke/twilight.nvim",
  },
  config = function()
    require("zen-mode").setup({
      window = {
        width = 0.85,
        options = {
          number = false,
          relativenumber = false,
        },
      },
      plugins = {
        kitty = {
          enabled = true,
        },
      },
    })
  end,
}
