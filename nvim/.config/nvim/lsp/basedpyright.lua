---@type vim.lsp.LSPConfig
return {
    cmd = { "basedpyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    filetypes = { "python" },
    settings = {
        basedpyright = {
            -- Disable type checking for faster startup
            disableOrganizeImports = true,
            analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic", -- "off", "basic", or "strict"
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = false, -- Disable for performance
                diagnosticSeverityOverrides = {
                    reportUnusedImport = "warning", -- "none", "information", "warning", or "error"
                    reportUnusedVariable = "warning",
                    reportUnusedCallResult = "none",
                },
            },
        },
    },
}

