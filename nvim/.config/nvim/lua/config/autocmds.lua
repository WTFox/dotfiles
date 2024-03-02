-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set relative line numbers in normal mode and absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  command = "set norelativenumber",
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  command = "set relativenumber",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "kanagawa",
  callback = function()
    if vim.o.background == "light" then
      vim.fn.system("kitty +kitten themes Kanagawa_light")
    elseif vim.o.background == "dark" then
      vim.fn.system("kitty +kitten themes Kanagawa_dragon")
    else
      vim.fn.system("kitty +kitten themes Kanagawa")
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "catppuccin*",
  callback = function()
    if vim.o.background == "light" then
      vim.fn.system("kitty +kitten themes Kanagawa_light")
    elseif vim.o.background == "dark" then
      vim.fn.system("kitty +kitten themes Catppuccin-Mocha")
    else
      vim.fn.system("kitty +kitten themes Kanagawa")
    end
  end,
})
