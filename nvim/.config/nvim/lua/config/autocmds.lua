-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    if vim.fn.bufname() ~= "copilot-chat" then
      vim.opt.relativenumber = false
    end
  end,
})

-- and absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if vim.fn.bufname() ~= "copilot-chat" then
      vim.opt.relativenumber = true
    end
  end,
})

-- disable auto pairs in Rust
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "rust",
  command = "let g:minipairs_disable = v:true",
})
