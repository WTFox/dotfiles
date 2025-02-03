-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

local map = vim.keymap.set
local term = require("snacks.terminal")
local lazygit = require("snacks.lazygit")

-- quick yank line/paste/comment prev line
map("n", "yc", "yy:lua MiniComment.operator('n')<CR>p", { noremap = true, silent = true })

-- quick clear highlighting
map("n", "<C-[>", "<cmd>nohlsearch<cr>", { noremap = true, silent = true })

-- quick change in word
map("n", "<C-c>", "ciw")

-- next quickfix item
map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- better redo
map("n", "U", "<c-r>", { noremap = true, silent = true, desc = "redo" })

-- quick window quit
map("n", "<leader>qw", ":q<cr>", { noremap = true, silent = true, desc = "quit window" })

-- leader backspace to delete buffer
map("n", "<leader><bs>", ":bd<cr>", { noremap = true, silent = true, desc = "delete buffer" })

-- move line up and down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- capital Q to quit
map("n", "Q", "<esc>:q<cr>", { noremap = true, silent = true })

-- floating terminal
map("n", "<c-/>", function()
  term.toggle()
end, { desc = "Terminal (root dir)" })

-- lazygit
map("n", "<leader>gg", function()
  lazygit.open()
end, { desc = "Lazygit (root dir)" })

-- lazydocker
map("n", "<leader>dd", function()
  term.toggle("lazydocker")
end, { desc = "LazyDocker" })

-- diff
map("n", "<leader>ds", "<cmd>windo diffthis<cr>", { desc = "Diff Split" })
