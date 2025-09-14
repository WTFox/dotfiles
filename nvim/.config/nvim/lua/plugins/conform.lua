return {
    src = "https://github.com/stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "isort", "black" },
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "lsp" },
                html = { "lsp" },
                css = { "lsp" },
                go = { "lsp" },
                rust = { "lsp" },
                c = { "lsp" },
                cpp = { "lsp" },
                bash = { "lsp" },
                sh = { "lsp" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters = {
                black = {
                    prepend_args = { "--fast" },
                },
                isort = {
                    prepend_args = { "--profile", "black" },
                },
                prettier = {
                    prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
                },
            },
        })
    end
}