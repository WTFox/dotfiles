return {
  "JellyApple102/flote.nvim",
  keys = { { "<leader>n", "<cmd>Flote<cr>", desc = "Project Notes" } },
  config = function()
    require("flote").setup()
  end,
}
