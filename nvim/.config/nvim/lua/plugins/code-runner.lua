-- vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

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
  },
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
    { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
    { "<leader>rft", "<cmd>RunFile tab<cr>", desc = "Run File in Tab" },
    { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    { "<leader>rc", "<cmd>RunClose<cr>", desc = "Run Close" },
    { "<leader>crf", "<cmd>CRFiletype<cr>", desc = "CR Filetype" },
    { "<leader>crp", "<cmd>CRProjects<cr>", desc = "CR Projects" },
  },
}
