---@type vim.lsp.LSPConfig
return {
    cmd = { "basedpyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    filetypes = { "python" },
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic", -- "off", "basic", or "strict"
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedImport = "warning", -- "none", "information", "warning", or "error"
                    reportUnusedVariable = "warning",
                    reportUnusedCallResult = "none",
                },
            },
        },
    },
}
