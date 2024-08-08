-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  command = "set norelativenumber",
})

-- and absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  command = "set relativenumber",
})

-- disable auto pairs in Rust
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "rust",
  command = "let g:minipairs_disable = v:true",
})
