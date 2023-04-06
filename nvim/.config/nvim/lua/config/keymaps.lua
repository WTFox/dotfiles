-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

local map = vim.keymap.set

-- toggle dashboard (alpha)
map("n", "<leader>a", ":Alpha<cr>", { noremap = true, silent = true, desc = "dashboard" })

-- next quickfix item
map("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
map("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- Toggle ZenMode
map("n", "<leader>uz", ":ZenMode<cr>", { noremap = true, silent = true, desc = "Zen" })

-- Flote notes
map("n", "<leader>n", "<cmd>Flote<cr>", { noremap = true, silent = true, desc = "Notes" })

-- use dynamic workspace symbols
map("n", "<leader>sS", function()
  local telescope = require("telescope.builtin")
  telescope.lsp_dynamic_workspace_symbols()
end, { noremap = true, silent = true, desc = "workspace symbols" })

-- open diffview
map("n", "<leader>gd", ":DiffviewOpen<cr>", { noremap = true, silent = true, desc = "diffview" })
