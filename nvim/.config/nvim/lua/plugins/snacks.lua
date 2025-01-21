local Snacks = require("snacks")

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      formatters = {
        file = {
          filename_first = true,
        },
      },
      layout = {
        -- layout = { backdrop = false },
        -- layout = {
        --   backdrop = false,
        --   box = "vertical",
        --   row = -1,
        --   width = 0,
        --   height = 0.7,
        --   border = "top",
        --   title = " {source} {live}",
        --   title_pos = "left",
        --   { win = "input", height = 1, border = "bottom" },
        --   {
        --     box = "horizontal",
        --     { win = "list", border = "none" },
        --     { win = "preview", width = 0.6, border = "left" },
        --   },
        -- },
      },
    },
    scope = {
      treesitter = {
        blocks = {
          "function_declaration",
          "function_definition",
          "method_declaration",
          "method_definition",
          "class_declaration",
          "class_definition",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
          "try_statement",
          "with_statement",
        },
      },
    },
    indent = {
      enabled = false,
      animate = {
        enabled = false,
      },
    },
    dashboard = {
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    zen = {
      win = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 150,
        height = 0,
        backdrop = { transparent = true, blend = 10 },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
      },
    },
  },
}
