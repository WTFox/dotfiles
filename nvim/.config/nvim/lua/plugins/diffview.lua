return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen main<cr>", desc = "DiffView (main)" },
    { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
  },
}
