return {
  "matbme/JABS.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    sort_mru = true,
    -- split_filename = true,
    -- split_filename_path_width = 40,
    width = 60,
    height = 10,
    border = "shadow",
  },
  keys = {
    { "<C-p>", "<cmd>JABSOpen<cr>", desc = "Show Buffers" },
  },
}
