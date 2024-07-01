return {
  "petertriho/nvim-scrollbar",
  opts = {
    handle = {
      highlight = "Comment",
    },
    excluded_filetypes = {
      "cmp_docs",
      "cmp_menu",
      "noice",
      "prompt",
      "TelescopePrompt",
      "dashboard",
      "neo-tree",
    },
    handlers = {
      cursor = false,
      diagnostic = false,
    },
  },
}
