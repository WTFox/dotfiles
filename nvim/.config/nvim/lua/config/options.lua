local opt = vim.opt

vim.cmd.colorscheme("jellybeans")

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

-- UI
opt.guicursor = "i:block-blinkwait700-blinkoff400-blinkon250"
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.list = true
opt.listchars = {
    tab = "  ",
    trail = "·",
    extends = "→",
    precedes = "←",
    nbsp = "␣",
}

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
opt.autoread = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldcolumn = "1"
-- opt.foldtext = "v:lua.require('config.folds').foldtext()"

-- Performance
-- opt.timeoutlen = 300
-- opt.ttimeoutlen = 0
-- opt.updatetime = 250
opt.lazyredraw = false
