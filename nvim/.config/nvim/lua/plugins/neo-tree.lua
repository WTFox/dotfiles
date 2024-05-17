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
    filesystem = {
      filtered_items = {
        never_show = {
          "__pycache__",
        },
        always_show = {
          ".github",
        },
      },
    },
  },
}
