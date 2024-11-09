-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

local map = vim.keymap.set
local term = require("snacks.terminal")
local lazygit = require("snacks.lazygit")

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

-- resume telescope after exiting
map("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>")

-- move line up and down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- capital Q to quit
map("n", "Q", "<esc>:q<cr>", { noremap = true, silent = true })

-- delete vim terminal mappings
-- vim.keymap.del("t", "<c-l>")
-- vim.keymap.del("t", "<c-k>")

-- floating terminal
map("n", "<c-/>", function()
  term.toggle()
end, { desc = "Terminal (root dir)" })
-- map("n", "<c-_>", term, { desc = "which_key_ignore" })

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
