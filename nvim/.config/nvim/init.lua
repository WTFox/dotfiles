vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.g.copilot = false

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.autocmds")
