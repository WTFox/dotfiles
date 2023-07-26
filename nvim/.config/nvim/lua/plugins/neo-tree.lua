return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
