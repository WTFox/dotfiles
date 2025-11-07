_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end
vim.print = _G.dd

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.g.copilot = false

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.autocmds")
