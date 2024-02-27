return {
  "matbme/JABS.nvim",
  enabled = true,
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
    use_devicons = false,
    symbols = {
      current = "C", -- default 
      split = "S", -- default 
      alternate = "A", -- default 
      hidden = "H", -- default ﬘
      locked = "L", -- default 
      ro = "R", -- default 
      edited = "E", -- default 
      terminal = "T", -- default 
      default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
      terminal_symbol = ">_", -- Filetype icon for a terminal split. Default 
    },
  },
  keys = {
    { "<C-p>", "<cmd>JABSOpen<cr>", desc = "Show Buffers" },
  },
}
