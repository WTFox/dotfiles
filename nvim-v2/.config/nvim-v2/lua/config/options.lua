-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.filetype.add {
  extension = { mdx = 'markdown.mdx' },
  filename = {
    ['.env'] = 'sh',
    ['.env.example'] = 'sh',
    ['.envrc'] = 'sh',
    ['.envrc.local'] = 'sh',
    ['requirements.txt'] = 'config',
    ['requirements-dev.txt'] = 'config',
    ['requirements-test.txt'] = 'config',
  },
}

-- don't show tab indicators
vim.opt.listchars = { tab = '  ' }

-- vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.root_spec = { 'cwd' }
vim.opt.guicursor = 'n-v-c-sm-ve:block,i-ci:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

-- make windows opaque
-- vim.opt.pumblend = 0 -- for cmp menu
-- vim.opt.winblend = 0 -- for documentation popup

vim.g.snacks_animate = false

vim.opt.number = false
vim.opt.relativenumber = false

-- vim.opt.numberwidth = 3
-- vim.opt.signcolumn = "yes:1"
-- vim.opt.statuscolumn = "%l%s"
