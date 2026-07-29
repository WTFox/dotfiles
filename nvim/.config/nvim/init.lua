vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.autocmds")
require("config.dev")

-- jdtls is started by nvim-jdtls instead (see lua/plugins/nvim-jdtls.lua)
vim.lsp.enable({
    "basedpyright",
    "bashls",
    "clangd",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "ruff",
    "rust_analyzer",
    "ts_ls",
    "yamlls",
})
