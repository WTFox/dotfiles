require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "stylua",
        "ts_ls",
    },
})


vim.diagnostic.config({
    signs = true,
    underline = false
})
