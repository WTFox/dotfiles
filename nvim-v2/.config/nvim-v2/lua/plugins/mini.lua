return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      statusline.section_location = function()
        return '%3l:%-3v %3p%%'
      end

      -- statusline.section_location = function()
      --   local line = vim.fn.line '.'
      --   local col = vim.fn.virtcol '.'
      --   local total = vim.fn.line '$'
      --   return string.format('%d/%d:%d', line, total, col)
      -- end

      require('mini.splitjoin').setup {
        -- Use `gS` to split/join lines
        mappings = {
          toggle = 'gS',
          split = 'gJ',
          join = 'gK',
        },
      }

      require('mini.surround').setup {
        -- Custom mappings for surround actions
        mappings = {
          add = 'gsa', -- Add surrounding
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          update_n_lines = 'gsn', -- Update number of lines in surrounding
        },
      }
    end,
  },
}
