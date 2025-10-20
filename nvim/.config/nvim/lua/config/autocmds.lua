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

-- Prevent LSP formatting when global autoformat is disabled
autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentFormattingProvider then
            autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    if not vim.g.disable_autoformat and not vim.b.disable_autoformat then
                        vim.lsp.buf.format({ async = false })
                    end
                end,
            })
        end
    end,
})

-- Maintain split proportions on terminal resize
autocmd("VimResized", {
    pattern = "*",
    callback = function()
        vim.cmd("wincmd =")
    end,
})

