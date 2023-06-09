return {
  "CRAG666/code_runner.nvim",
  config = true,
  lazy = true,
  opts = {
    filetype = {
      go = {
        "go run $fileName",
      },
    },
    mode = "term",
    focus = true,
    startinsert = false,
    insert_prefix = "",
    term = {
      position = "bot",
      size = 12,
    },
  },
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
    -- { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
    -- { "<leader>rft", "<cmd>RunFile tab<cr>", desc = "Run File in Tab" },
    -- { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    -- { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
  },
}
