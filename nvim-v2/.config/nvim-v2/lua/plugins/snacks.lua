--  v2
local Utils = require 'utils'

local layouts = {
  default = {
    layout = {
      box = 'horizontal',
      width = 0.8,
      min_width = 120,
      height = 0.8,
      {
        box = 'vertical',
        border = 'rounded',
        title = '{title} {live} {flags}',
        { win = 'input', height = 1, border = 'bottom' },
        { win = 'list', border = 'none' },
      },
      { win = 'preview', title = '{preview}', border = 'rounded', width = 0.5 },
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
      border = 'none',
      box = 'vertical',
      { win = 'input', height = 1, border = 'rounded', title = '{title} {live} {flags}', title_pos = 'center' },
      { win = 'list', border = 'hpad' },
      { win = 'preview', title = '{preview}', border = 'rounded' },
    },
  },
  ivy_split_below = {
    preview = 'main',
    layout = {
      box = 'vertical',
      backdrop = false,
      width = 0,
      height = 0.4,
      position = 'bottom',
      border = 'top',
      title = ' {title} {live} {flags}',
      title_pos = 'left',
      { win = 'input', height = 1, border = 'bottom' },
      {
        box = 'horizontal',
        { win = 'list', border = 'none' },
        { win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
      },
    },
  },
  ivy = {
    layout = {
      box = 'vertical',
      backdrop = false,
      row = -1,
      width = 0,
      height = 0.4,
      border = 'top',
      title = ' {title} {live} {flags}',
      title_pos = 'left',
      { win = 'input', height = 1, border = 'bottom' },
      {
        box = 'horizontal',
        { win = 'list', border = 'none' },
        { win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
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
      box = 'vertical',
      border = 'rounded',
      title = '{title}',
      title_pos = 'center',
      { win = 'input', height = 1, border = 'bottom' },
      { win = 'list', border = 'none' },
      { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
    },
  },
  sidebar = {
    preview = 'main',
    layout = {
      backdrop = false,
      width = 40,
      min_width = 40,
      height = 0,
      position = 'left',
      border = 'none',
      box = 'vertical',
      {
        win = 'input',
        height = 1,
        border = 'rounded',
        title = '{title} {live} {flags}',
        title_pos = 'center',
      },
      { win = 'list', border = 'none' },
      { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
    },
  },
  telescope = {
    reverse = true,
    layout = {
      box = 'horizontal',
      backdrop = false,
      width = 0.8,
      height = 0.9,
      border = 'none',
      {
        box = 'vertical',
        { win = 'list', title = ' Results ', title_pos = 'center', border = 'rounded' },
        { win = 'input', height = 1, border = 'rounded', title = '{title} {live} {flags}', title_pos = 'center' },
      },
      {
        win = 'preview',
        title = '{preview:Preview}',
        width = 0.45,
        border = 'rounded',
        title_pos = 'center',
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
      border = 'none',
      box = 'vertical',
      { win = 'preview', title = '{preview}', height = 0.4, border = 'rounded' },
      {
        box = 'vertical',
        border = 'rounded',
        title = '{title} {live} {flags}',
        title_pos = 'center',
        { win = 'input', height = 1, border = 'bottom' },
        { win = 'list', border = 'none' },
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
      position = 'right',
      border = 'none',
      box = 'vertical',
      {
        win = 'input',
        height = 1,
        border = 'rounded',
        title = '{title} {live} {flags}',
        title_pos = 'center',
      },
      { win = 'list', border = 'none' },
      -- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
  },
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
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
                ['o'] = 'confirm',
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
          'function_declaration',
          'function_definition',
          'method_declaration',
          'method_definition',
          'class_declaration',
          'class_definition',
          'do_statement',
          'while_statement',
          'repeat_statement',
          'if_statement',
          'for_statement',
          'try_statement',
          'with_statement',
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
        { section = 'header' },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        {
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          cwd = true,
          indent = 2,
          padding = 1,
        },
        { section = 'startup' },
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
          winhighlight = 'NormalFloat:Normal',
        },
      },
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        Snacks.picker.explorer()
      end,
      'Explorer',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      'Git Status',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader><space>',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files (Root Dir)',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    -- find
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fB',
      function()
        Snacks.picker.buffers { hidden = true, nofile = true }
      end,
      desc = 'Buffers (all)',
    },
    -- { '<leader>fc', LazyVim.pick.config_files(), desc = 'Find Config File' },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files (Root Dir)',
    },
    -- { '<leader>fF', LazyVim.pick('files', { root = false }), desc = 'Find Files (cwd)' },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Files (git-files)',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    -- git
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (hunks)',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep (Root Dir)',
    },
    -- { '<leader>sG', LazyVim.pick('live_grep', { root = false }), desc = 'Grep (cwd)' },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word (Root Dir)',
      mode = { 'n', 'x' },
    },
    -- { '<leader>sW', LazyVim.pick('grep_word', { root = false }), desc = 'Visual selection or word (cwd)', mode = { 'n', 'x' } },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Document Symbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'Workspace Symbols',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undotree',
    },
    -- ui
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
  },
}
