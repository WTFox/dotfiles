return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer NeoTree (local to file)",
      remap = true,
    },
  },
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
