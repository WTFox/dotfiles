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
                "flake8",
                "gopls",
                "html",
                "isort",
                "jdtls",
                "jsonls",
                "lua_ls",
                "rust_analyzer",
                "shfmt",
                "stylua",
                "ts_ls",
                -- "pyright",
            },
        },
    },
}
