vim.g.gitblame_message_template = "<sha> • <date> • <author>"
vim.g.gitblame_date_format = "%Y-%m-%d %H:%M:%S"

return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  keys = {
    { "<leader>goc", "<cmd>GitBlameOpenCommitURL<CR>", desc = "Open commit url" },
    { "<leader>gof", "<cmd>GitBlameOpenFileURL<CR>", desc = "Open file url" },
  },
}
