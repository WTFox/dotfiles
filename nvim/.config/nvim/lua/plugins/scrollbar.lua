local colors = require("tokyonight.colors")

return {
  "petertriho/nvim-scrollbar",
  opts = {
    handle = {
      -- color = "#cdd6f4",
      color = colors.bg_highlight,
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
