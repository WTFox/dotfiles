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
vim.keymap.set("n", "]q", ":cnext<cr>zz", { noremap = true, silent = true, desc = "next quickfix" })

-- prev quickfix item
vim.keymap.set("n", "[q", ":cprev<cr>zz", { noremap = true, silent = true, desc = "prev quickfix" })

-- Open copilot panel
vim.keymap.set("n", "<M-.>", ":Copilot panel<cr>", { noremap = true, silent = true, desc = "copilot panel" })

-- Toggle ZenMode
vim.keymap.set("n", "<leader>uz", ":ZenMode<cr>", { noremap = true, silent = true, desc = "Zen" })
