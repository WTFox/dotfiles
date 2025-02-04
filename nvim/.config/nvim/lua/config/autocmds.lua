local Utils = require("utils")
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local auto = vim.api.nvim_create_autocmd

-- Set relative line numbers in normal mode
local ignored_filetypes = {
  "copilot-chat",
  "snacks_dashboard",
  "snacks_picker_list",
}
auto({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    if not Utils.contains(ignored_filetypes, vim.bo.filetype) then
      vim.opt.relativenumber = false
    end
  end,
})

-- and absolute line numbers in insert mode
auto({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    if not Utils.contains(ignored_filetypes, vim.bo.filetype) then
      vim.opt.relativenumber = true
    end
  end,
})

-- disable auto pairs in Rust
auto({ "FileType" }, {
  pattern = "rust",
  command = "let g:minipairs_disable = v:true",
})
