return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "blame" },
    },
  },
  -- {
  --   "FabijanZulj/blame.nvim",
  --   keys = {
  --     { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "blame" },
  --   },
  -- },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen main<cr>", desc = "DiffView (main)" },
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    },
  },
}
