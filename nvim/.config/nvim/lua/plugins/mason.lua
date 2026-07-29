return {
    { "mason-org/mason.nvim", event = "BufReadPre", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            -- stylua is a formatter, not a language server; jdtls is started by
            -- nvim-jdtls instead of the bundled lspconfig default
            automatic_enable = { exclude = { "stylua", "jdtls" } },
        },
        event = "BufReadPre",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "BufReadPre",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                -- servers
                "basedpyright",
                "bashls",
                "clangd",
                "cssls",
                "eslint",
                "gopls",
                "html",
                "jdtls",
                "jsonls",
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "yamlls",
                -- formatters
                "black",
                "isort",
                "prettier",
                "shfmt",
                "stylua",
            },
        },
    },
}
