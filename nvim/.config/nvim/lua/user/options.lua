local options = {
  backup        = false, -- creates a backup file
  cc            = "120", -- vertical column at 120 chars
  clipboard     = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight     = 2, -- more space in the neovim command line for displaying messages
  completeopt   = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel  = 0, -- so that `` is visible in markdown files
  cursorline    = true, -- highlight the current line
  expandtab     = true, -- convert tabs to spaces
  fileencoding  = "utf-8", -- the encoding written to a file
  hlsearch      = true, -- highlight all matches on previous search pattern
  ignorecase    = true, -- ignore case in search patterns
  mouse         = "a", -- allow the mouse to be used in neovim
  number        = true, -- set numbered lines
  numberwidth   = 2, -- set number column width to 2 {default 4}
  pumheight     = 10, -- pop up menu height
  scrolloff     = 5, -- is one of my fav
  shiftwidth    = 2, -- the number of spaces inserted for each indentation
  showmode      = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline   = 2, -- always show tabs
  sidescrolloff = 5,
  signcolumn    = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase     = true, -- smart case
  smartindent   = true, -- make indenting smarter again
  splitbelow    = true, -- force all horizontal splits to go below current window
  splitright    = true, -- force all vertical splits to go to the right of current window
  swapfile      = false, -- creates a swapfile
  tabstop       = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen    = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile      = true, -- enable persistent undo
  updatetime    = 300, -- faster completion (4000ms default)
  wrap          = false, -- display lines as one long line
  writebackup   = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

--[[ vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, { ]]
--[[   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}), ]]
--[[   callback = function() ]]
--[[     vim.opt.foldmethod = 'expr' ]]
--[[     vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()' ]]
--[[   end ]]
--[[ }) ]]

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
