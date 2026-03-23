return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        formatters_by_ft = {
            python = function(bufnr)
                local root = vim.fs.root(bufnr, { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" })
                if root then
                    if vim.fn.filereadable(root .. "/ruff.toml") == 1 or vim.fn.filereadable(root .. "/.ruff.toml") == 1 then
                        return { "ruff_fix", "ruff_format" }
                    end
                    local pyproject = root .. "/pyproject.toml"
                    if vim.fn.filereadable(pyproject) == 1 then
                        for _, line in ipairs(vim.fn.readfile(pyproject)) do
                            if line:match("%[tool%.ruff") then
                                return { "ruff_fix", "ruff_format" }
                            end
                        end
                    end
                end
                return { "isort", "black" }
            end,
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
        format_after_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            -- Trim trailing whitespace and empty lines after formatting
            if pcall(require, "mini.trailspace") then
                require("mini.trailspace").trim()
                require("mini.trailspace").trim_last_lines()
            end
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
