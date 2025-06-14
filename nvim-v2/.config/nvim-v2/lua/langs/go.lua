-- Framework-agnostic Go configuration for Neovim

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'go', 'gomod', 'gowork', 'gosum' } },
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Set up gopls with all settings
      lspconfig.gopls.setup {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
          },
        },
        on_attach = function(client, bufnr)
          -- Workaround for gopls not supporting semanticTokensProvider
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end

          -- Set up Go-specific keymaps
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to Definition' }))
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to Declaration' }))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to Implementation' }))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show References' }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
        end,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      }
    end,
  },

  -- Ensure Go tools are installed
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'gopls' },
      }

      -- Also ensure formatting tools are installed
      local mason_registry = require 'mason-registry'
      local tools = { 'goimports', 'gofumpt', 'gomodifytags', 'impl', 'delve' }

      for _, tool in ipairs(tools) do
        local ok, pkg = pcall(mason_registry.get_package, tool)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofumpt,
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          go = { 'goimports', 'gofumpt' },
        },
      }
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'leoluz/nvim-dap-go',
        config = function()
          require('dap-go').setup()
        end,
      },
    },
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'fredrikaverpil/neotest-golang',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-golang' {
            -- Here we can set options for neotest-golang, e.g.
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          },
        },
      }
    end,
  },

  -- Filetype icons
  {
    'echasnovski/mini.icons',
    config = function()
      require('mini.icons').setup {
        file = {
          ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
        },
        filetype = {
          gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
        },
      }
    end,
  },
}
