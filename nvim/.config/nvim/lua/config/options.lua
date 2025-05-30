-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- adds filename to top right of buffer
-- vim.opt.winbar = "%=%m %f"

-- disable auto pairs
-- vim.g.minipairs_disable = true

-- add highlighting to weird files
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".env.example"] = "sh",
    [".envrc"] = "sh",
    [".envrc.local"] = "sh",
    ["requirements.txt"] = "config",
    ["requirements-dev.txt"] = "config",
    ["requirements-test.txt"] = "config",
  },
})

-- don't show tab indicators
vim.opt.listchars = { tab = "  " }

-- vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.root_spec = { "cwd" }
vim.opt.guicursor = "n-v-c-sm-ve:block,i-ci:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- make windows opaque
-- vim.opt.pumblend = 0 -- for cmp menu
-- vim.opt.winblend = 0 -- for documentation popup

vim.g.snacks_animate = false

vim.opt.number = false
vim.opt.relativenumber = false

-- vim.opt.numberwidth = 3
-- vim.opt.signcolumn = "yes:1"
-- vim.opt.statuscolumn = "%l%s"
