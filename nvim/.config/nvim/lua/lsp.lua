require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
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
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    },
    underline = true,
    virtual_text = {
        spacing = 4,
        prefix = "●",
        suffix = "",
        format = function(diagnostic)
            return string.format("%s", diagnostic.message)
        end,
    },
})

-- local ignore = {
--     "basedpyright",
--     "pyright",
-- }
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("inlay-hintsAttach", { clear = true }),
--     callback = function(event)
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--
--         if client and vim.tbl_contains(ignore, client.name) then
--             return
--         end
--
--         if client and client.server_capabilities.inlayHintProvider then
--             vim.api.nvim_create_autocmd("InsertEnter", {
--                 buffer = event.buf,
--                 callback = function()
--                     vim.lsp.inlay_hint.enable(false)
--                 end,
--             })
--             vim.api.nvim_create_autocmd({ "InsertLeave", "LspNotify" }, {
--                 buffer = event.buf,
--                 callback = function()
--                     vim.lsp.inlay_hint.enable(true)
--                 end,
--             })
--         end
--     end,
-- })
