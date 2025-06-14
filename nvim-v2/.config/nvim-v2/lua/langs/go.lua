-- Framework-agnostic Go configuration for Neovim

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp_keymaps = true,
      -- other options
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
        require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Ensure Go tools are installed
  -- {
  --   'williamboman/mason.nvim',
  --   config = function()
  --     require('mason').setup()
  --
  --     -- Also ensure formatting tools are installed
  --     local mason_registry = require 'mason-registry'
  --     local tools = { 'goimports', 'gofumpt', 'gomodifytags', 'impl', 'delve' }
  --
  --     for _, tool in ipairs(tools) do
  --       local ok, pkg = pcall(mason_registry.get_package, tool)
  --       if ok and not pkg:is_installed() then
  --         pkg:install()
  --       end
  --     end
  --   end,
  -- },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofumpt,
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")({
            -- Here we can set options for neotest-golang, e.g.
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          }),
        },
      })
    end,
  },
  -- {
  -- 'neovim/nvim-lspconfig',
  -- opts = {
  --   servers = {
  --     gopls = {
  --       settings = {
  --         gopls = {
  --           gofumpt = true,
  --           codelenses = {
  --             gc_details = false,
  --             generate = true,
  --             regenerate_cgo = true,
  --             run_govulncheck = true,
  --             test = true,
  --             tidy = true,
  --             upgrade_dependency = true,
  --             vendor = true,
  --           },
  --           hints = {
  --             assignVariableTypes = true,
  --             compositeLiteralFields = true,
  --             compositeLiteralTypes = true,
  --             constantValues = true,
  --             functionTypeParameters = true,
  --             parameterNames = true,
  --             rangeVariableTypes = true,
  --           },
  --           analyses = {
  --             nilness = true,
  --             unusedparams = true,
  --             unusedwrite = true,
  --             useany = true,
  --           },
  --           usePlaceholders = true,
  --           completeUnimported = true,
  --           staticcheck = true,
  --           directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
  --           semanticTokens = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  -- },

  -- Filetype icons
  {
    "echasnovski/mini.icons",
    config = function()
      require("mini.icons").setup({
        file = {
          [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
        },
        filetype = {
          gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
        },
      })
    end,
  },
}
