require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "stylua",
        "pyright",
        "rust_analyzer",
        "clangd",
        "gopls",
        "eslint",
        "html",
        "cssls",
        "jsonls",
        "bashls",
    },
})


vim.diagnostic.config({ 
    signs = true,
    underline = false 
})
