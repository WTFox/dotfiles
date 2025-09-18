vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.autocmds")

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLIneNumError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineNumWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    },
    underline = true,
    -- virtual_text = {
    --     spacing = 4,
    --     prefix = "●",
    --     suffix = "",
    --     format = function(diagnostic)
    --         return string.format("%s", diagnostic.message)
    --     end,
    -- },
})

vim.cmd.colorscheme("jellybeans")
