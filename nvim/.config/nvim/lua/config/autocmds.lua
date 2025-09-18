local Utils = require("utils")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local bs = { buffer = true, silent = true }
local brs = { buffer = true, remap = true, silent = true }

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Auto-reload buffers when focused
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

-- Set relative line numbers in normal mode
local ignored_filetypes = {
    "copilot-chat",
    "snacks_dashboard",
    "snacks_picker_list",
}
autocmd({ "InsertEnter" }, {
    pattern = "*",
    callback = function()
        if not Utils.contains(ignored_filetypes, vim.bo.filetype) then
            vim.opt.relativenumber = false
        end
    end,
})

-- and absolute line numbers in insert mode
autocmd({ "InsertLeave" }, {
    pattern = "*",
    callback = function()
        if not Utils.contains(ignored_filetypes, vim.bo.filetype) then
            vim.opt.relativenumber = true
        end
    end,
})
