return {
    {
        "neovim/nvim-lspconfig",
        enabled = false,
    },

    {
        "mason-org/mason.nvim",
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "basedpyright",
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
                -- "pyright",
                "rust_analyzer",
                "stylua",
                "ts_ls",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
    },
}
