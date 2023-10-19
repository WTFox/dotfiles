vim.g.undotree_WindowLayout = 3

return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    {
      "<leader>U",
      "<CMD>UndotreeToggle<CR>",
      desc = "UndoTree",
      { noremap = true, silent = true },
    },
  },
}
