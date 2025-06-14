return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          vim.ui.input({
            prompt = 'Quick Chat: ',
          }, function(input)
            if input ~= '' then
              require('CopilotChat').ask(input)
            end
          end)
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = '<c-e>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        text = false,
        zsh = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            return false
          end
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.envrc.*') then
            return false
          end
          return true
        end,
      },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = {
      'giuxtaposition/blink-cmp-copilot',
    },
    opts = {
      sources = {
        default = {
          'copilot',
          'lsp',
          'path',
          'buffer',
          'snippets',
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
