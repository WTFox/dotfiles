vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.autocmds")
