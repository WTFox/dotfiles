return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
    },
    window = {
      position = "right",
      mappings = {
        ["<space>"] = "none",
        ["o"] = "open",
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
  },
}
