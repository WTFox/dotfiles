require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
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
        "pyright",
        "rust_analyzer",
        "stylua",
        "ts_ls",
    },
})


-- Fix for change_annotations issue with pyright
local function fix_workspace_edit(workspace_edit)
    if workspace_edit and workspace_edit.documentChanges then
        for _, change in ipairs(workspace_edit.documentChanges) do
            if change.edits then
                for _, edit in ipairs(change.edits) do
                    if edit.annotationId and not workspace_edit.changeAnnotations then
                        edit.annotationId = nil
                    end
                end
            end
        end
    end
    return workspace_edit
end

local original_apply_workspace_edit = vim.lsp.util.apply_workspace_edit
vim.lsp.util.apply_workspace_edit = function(workspace_edit, offset_encoding)
    return original_apply_workspace_edit(fix_workspace_edit(workspace_edit), offset_encoding)
end

vim.diagnostic.config({
    signs = {
        linehl = {},
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
        },
    },
    underline = false,
    virtual_text = {
        spacing = 4,
        prefix = "●",
        suffix = "",
        format = function(diagnostic)
            return string.format("%s", diagnostic.message)
        end,
    },
})
