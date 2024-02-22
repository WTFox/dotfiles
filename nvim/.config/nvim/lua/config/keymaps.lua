-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

local Util = require("lazyvim.util")
local map = vim.keymap.set

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

-- enter in normal mode to change word
map("n", "<cr>", "ciw")

-- resume telescope after exiting
map("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>")

-- tab to next buffer
-- shift tab to previous buffer
-- map("n", "<Tab>", ":bnext<cr>")
-- map("n", "<S-Tab>", ":bprevious<cr>")

-- shift-tab to show buffer list
map("n", "<S-Tab>", ":Telescope buffers<cr>")

-- leader a to show dashboard
map("n", "<leader>a", ":Dashboard<cr>")

-- move line up and down
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- capital Q to quit
map("n", "Q", "<esc>:q<cr>", { noremap = true, silent = true })

-- delete vim terminal mappings
vim.keymap.del("t", "<c-l>")
vim.keymap.del("t", "<c-k>")

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })

map("n", "<leader>fT", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })

map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })

map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- lazygit
map("n", "<leader>gg", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (root dir)" })

map("n", "<leader>gG", function()
  Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })

-- lazydocker
map("n", "<leader>dd", function()
  Util.terminal({ "lazydocker" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "LazyDocker" })

-- toggle background
map("n", "<leader>ub", function()
  Util.toggle("background", false, { "light", "dark" })
end, { desc = "Toggle Background" })

-- telescope find git files quicker
map(
  "n",
  "<C-p>",
  ":lua require('telescope.builtin').git_files()<cr>",
  { noremap = true, silent = true, desc = "Find Git Files" }
)

-- yazi
map("n", "<leader>yy", function()
  Util.terminal({ "yazi" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Yazi" })
