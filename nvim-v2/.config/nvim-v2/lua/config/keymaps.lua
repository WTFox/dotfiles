-- Save undo history
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- quick yank line/paste/comment prev line
map("n", "yc", "yy:lua require('mini.comment').operator('n')<CR>p", { noremap = true, silent = true })

-- quick clear highlighting
map("n", "<C-[>", "<cmd>nohlsearch<cr>", { noremap = true, silent = true })

-- next quickfix item
map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- better redo
-- map('n', 'U', '<c-r>', { noremap = true, silent = true, desc = 'redo' })

-- quick window quit
-- map('n', '<leader>qw', ':q<cr>', { noremap = true, silent = true, desc = 'quit window' })

-- leader backspace to delete buffer
-- map('n', '<leader><bs>', ':bd<cr>', { noremap = true, silent = true, desc = 'delete buffer' })

-- move line up and down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- capital Q to quit
map("n", "Q", "<esc>:q<cr>", { noremap = true, silent = true })

-- floating terminal
map("n", "<c-/>", function()
  require("snacks.terminal").toggle()
end, { desc = "Terminal (root dir)" })

-- lazygit
map("n", "<leader>gg", function()
  require("snacks.lazygit").open()
end, { desc = "Lazygit (root dir)" })

-- lazydocker
map("n", "<leader>dd", function()
  require("snacks.terminal").toggle("lazydocker")
end, { desc = "LazyDocker" })

-- diff
map("n", "<leader>ds", "<cmd>windo diffthis<cr>", { desc = "Diff Split" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

map("n", "<C-s>", "<cmd>:w<cr>")
map("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit" })

map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- toggle options
map("n", "<leader>us", function()
  Snacks.toggle.option("spell", { name = "Spelling" })
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Snacks.toggle.option("wrap", { name = "Wrap" })
end, { desc = "Toggle Wrap" })
map("n", "<leader>uL", function()
  Snacks.toggle.option("relativenumber", { name = "Relative Number" })
end, { desc = "Toggle Relative Number" })
map("n", "<leader>ud", function()
  Snacks.toggle.diagnostics()
end, { desc = "Toggle Diagnostics" })
map("n", "<leader>ul", function()
  Snacks.toggle.line_number()
end, { desc = "Toggle Line Number" })
map("n", "<leader>uc", function()
  Snacks.toggle.option(
    "conceallevel",
    { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
  )
end, { desc = "Toggle Conceal Level" })
map("n", "<leader>uA", function()
  Snacks.toggle.option(
    "showtabline",
    { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
  )
end, { desc = "Toggle Tabline" })
map("n", "<leader>uT", function()
  Snacks.toggle.treesitter()
end, { desc = "Toggle Treesitter" })
map("n", "<leader>ub", function()
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" })
end, { desc = "Toggle Dark Background" })
map("n", "<leader>uD", function()
  Snacks.toggle.dim()
end, { desc = "Toggle Dim" })
map("n", "<leader>ua", function()
  Snacks.toggle.animate()
end, { desc = "Toggle Animate" })
map("n", "<leader>ug", function()
  Snacks.toggle.indent()
end, { desc = "Toggle Indent" })
map("n", "<leader>uS", function()
  Snacks.toggle.scroll()
end, { desc = "Toggle Scroll" })
map("n", "<leader>dpp", function()
  Snacks.toggle.profiler()
end, { desc = "Toggle Profiler" })
map("n", "<leader>dph", function()
  Snacks.toggle.profiler_highlights()
end, { desc = "Toggle Profiler Highlights" })
