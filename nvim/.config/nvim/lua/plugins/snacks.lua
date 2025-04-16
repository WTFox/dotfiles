local Snacks = require("snacks")

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          layout = {
            layout = { backdrop = false },
            fullscreen = true,
          },
        },
        grep = {
          layout = {
            layout = { backdrop = false },
            fullscreen = true,
          },
        },
        explorer = {
          layout = {
            fullscreen = true,
            preview = true,
            layout = {
              backdrop = true,
              width = 40,
              min_width = 40,
              height = 0,
              position = "right",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              -- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
        },
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
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          cwd = true,
          indent = 2,
          padding = 1,
        },
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
