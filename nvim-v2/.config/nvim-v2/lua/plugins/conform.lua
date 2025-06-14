-- Formatter
-- https://github.com/stevearc/conform.nvim

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        css = { 'prettier' },
        go = { 'gofumpt', 'goimports', 'gosec', 'golines' },
        html = { 'prettier' },
        htmlangular = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        python = { 'black' },
        rust = { 'rustfmt' },
        scss = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    },
    init = function()
      -- Use conform for gq.
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    event = { 'BufWritePre' },
    enabled = not vim.g.vscode,
  },
}
