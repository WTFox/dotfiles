local Utils = require("utils")
local Snacks = require("snacks")

local layouts = {
  default = {
    layout = {
      box = "horizontal",
      width = 0.8,
      min_width = 120,
      height = 0.8,
      {
        box = "vertical",
        border = "rounded",
        title = "{title} {live} {flags}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
      { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
    },
  },
  vscode = {
    preview = false,
    layout = {
      backdrop = false,
      row = 1,
      width = 0.4,
      min_width = 80,
      height = 0.4,
      border = "none",
      box = "vertical",
      { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
      { win = "list", border = "hpad" },
      { win = "preview", title = "{preview}", border = "rounded" },
    },
  },
  ivy_split_below = {
    preview = "main",
    layout = {
      box = "vertical",
      backdrop = false,
      width = 0,
      height = 0.4,
      position = "bottom",
      border = "top",
      title = " {title} {live} {flags}",
      title_pos = "left",
      { win = "input", height = 1, border = "bottom" },
      {
        box = "horizontal",
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", width = 0.6, border = "left" },
      },
    },
  },
  ivy = {
    layout = {
      box = "vertical",
      backdrop = false,
      row = -1,
      width = 0,
      height = 0.4,
      border = "top",
      title = " {title} {live} {flags}",
      title_pos = "left",
      { win = "input", height = 1, border = "bottom" },
      {
        box = "horizontal",
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", width = 0.6, border = "left" },
      },
    },
  },
  select = {
    preview = false,
    layout = {
      backdrop = false,
      width = 0.5,
      min_width = 80,
      height = 0.4,
      min_height = 3,
      box = "vertical",
      border = "rounded",
      title = "{title}",
      title_pos = "center",
      { win = "input", height = 1, border = "bottom" },
      { win = "list", border = "none" },
      { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
  },
  sidebar = {
    preview = "main",
    layout = {
      backdrop = false,
      width = 40,
      min_width = 40,
      height = 0,
      position = "left",
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
      { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
  },
  telescope = {
    reverse = true,
    layout = {
      box = "horizontal",
      backdrop = false,
      width = 0.8,
      height = 0.9,
      border = "none",
      {
        box = "vertical",
        { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
        { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
      },
      {
        win = "preview",
        title = "{preview:Preview}",
        width = 0.45,
        border = "rounded",
        title_pos = "center",
      },
    },
  },
  dropdown = {
    layout = {
      backdrop = false,
      row = 1,
      width = 0.4,
      min_width = 80,
      height = 0.8,
      border = "none",
      box = "vertical",
      { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
      {
        box = "vertical",
        border = "rounded",
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
    },
  },
  explorer = {
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
}

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          layout = Utils.extend(layouts.default, { fullscreen = true }),
        },
        buffers = {
          layout = Utils.extend(layouts.vscode, { preview = false, fullscreen = false }),
        },
        git_branches = {
          layout = Utils.extend(layouts.default, { fullscreen = true }),
        },
        recent = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        git_diff = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        git_log = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        git_log_line = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        git_status = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        lsp_symbols = {
          layout = layouts.vscode,
        },
        lines = {
          layout = layouts.vscode,
        },
        grep = {
          layout = Utils.extend(layouts.ivy, { fullscreen = true }),
        },
        explorer = {
          auto_close = true,
          win = {
            list = {
              keys = {
                ["o"] = "confirm",
              },
            },
          },
          layout = layouts.explorer,
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
