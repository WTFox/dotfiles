-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

-- toggle dashboard (alpha)
vim.keymap.set("n", "<leader>a", ":Alpha<cr>", { noremap = true, silent = true, desc = "dashboard" })

-- next quickfix item
vim.keymap.set("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
vim.keymap.set("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- Toggle ZenMode
vim.keymap.set("n", "<leader>uz", ":ZenMode<cr>", { noremap = true, silent = true, desc = "Zen" })

-- use dynamic workspace symbols
vim.keymap.set("n", "<leader>sS", function()
  local telescope = require("telescope.builtin")
  telescope.lsp_dynamic_workspace_symbols()
end, { noremap = true, silent = true, desc = "workspace symbols" })
