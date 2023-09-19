return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ma", "<CMD>GrappleTag<CR>", { noremap = true, silent = true } },
    { "<leader>mm", "<CMD>GrapplePopup tags<CR>", { noremap = true, silent = true } },
  },
}
