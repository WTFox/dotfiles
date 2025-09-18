return {
    { "mason-org/mason.nvim", event = "BufReadPre", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        event = "BufReadPre",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
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
}
