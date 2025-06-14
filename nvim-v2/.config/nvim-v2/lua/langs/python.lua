-- Framework-agnostic Python configuration for Neovim
-- Only LSP and test adapter configuration

local lsp = 'pyright'
local ruff = 'ruff'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'rst', 'python' } },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Ruff configuration
      lspconfig.ruff.setup {
        cmd_env = { RUFF_TRACE = 'messages' },
        init_options = {
          settings = {
            logLevel = 'error',
          },
        },
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false

          -- Set up organize imports keymap
          vim.keymap.set('n', '<leader>co', function()
            vim.lsp.buf.code_action {
              filter = function(action)
                return action.kind == 'source.organizeImports'
              end,
              apply = true,
            }
          end, { buffer = bufnr, desc = 'Organize Imports' })
        end,
      }

      -- Pyright configuration
      lspconfig.pyright.setup {
        on_attach = function(_, bufnr)
          -- Any pyright-specific attach logic here
        end,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            -- Here you can specify the settings for the adapter
            -- runner = "pytest",
            -- python = ".venv/bin/python",
            dap = { justMyCode = false }, -- Disable DAP integration
          },
        },
      }
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    cmd = 'VenvSelect',
    ft = 'python',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('venv-selector').setup {
        settings = {
          options = {
            notify_user_on_venv_activation = true,
          },
        },
      }
    end,
    keys = {
      { '<leader>cv', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' },
    },
  },
  -- Optional: Mason LSP config to ensure Python LSPs are installed
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'pyright', 'ruff' },
      }
    end,
  },
}
