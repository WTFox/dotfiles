vim.g.mapleader = " "

local plugins = require("plugins")
vim.pack.add(plugins)

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

