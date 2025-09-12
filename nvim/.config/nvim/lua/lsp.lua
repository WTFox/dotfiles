require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "bashls",
        "black",
        "clangd",
        "cssls",
        "eslint",
        "gopls",
        "html",
        "isort",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "stylua",
        "ts_ls",
    },
})


vim.diagnostic.config({
    signs = {
        linehl = {},
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
        },
    },
    underline = false,
    virtual_text = {
        spacing = 4,
        prefix = "●",
        suffix = "",
        format = function(diagnostic)
            return string.format("%s", diagnostic.message)
        end,
    },
})
