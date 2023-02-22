-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- add any additional keymaps here

-- open last search in telescope
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "resume" }
)

-- toggle dashboard (alpha)
vim.keymap.set("n", "<leader>a", ":Alpha<cr>", { noremap = true, silent = true, desc = "dashboard" })

-- next quickfix item
vim.keymap.set("n", "<leader>]", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
vim.keymap.set("n", "<leader>[", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })
