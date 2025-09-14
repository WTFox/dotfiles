vim.g.mapleader = " "

require("plugin-manager").load_plugins()

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

