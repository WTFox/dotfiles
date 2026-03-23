---@type vim.lsp.Config
return {
    settings = {
        ruff = {
            -- Let conform handle formatting; ruff server is lint-only here
            format = { enabled = false },
        },
    },
}
