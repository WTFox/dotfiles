local opt = vim.opt

-- UI
opt.guicursor = "i:block"
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.number = true
opt.numberwidth = 2
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.list = true

-- Search
opt.ignorecase = true
opt.hlsearch = false
opt.inccommand = "nosplit"

-- Editing
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Files
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
