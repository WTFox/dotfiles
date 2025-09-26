return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
            sh = {
                "shfmt",
            },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return {
                timeout_ms = 5000,
                lsp_format = "fallback",
            }
        end,
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
    },
}
