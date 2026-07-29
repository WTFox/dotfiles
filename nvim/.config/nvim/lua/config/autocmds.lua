local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Auto-reload buffers when focused
local checktime_group = augroup("CheckTime", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    group = checktime_group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

-- Set relative line numbers in normal mode, absolute in insert mode
local relative_number_group = augroup("RelativeNumberToggle", { clear = true })
autocmd({ "InsertEnter" }, {
    pattern = "*",
    group = relative_number_group,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

autocmd({ "InsertLeave" }, {
    pattern = "*",
    group = relative_number_group,
    callback = function()
        vim.opt.relativenumber = true
    end,
})

-- Maintain split proportions on terminal resize
local resize_group = augroup("MaintainSplits", { clear = true })
autocmd("VimResized", {
    pattern = "*",
    group = resize_group,
    callback = function()
        vim.cmd("wincmd =")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "User: fix backdrop for lazy window",
    pattern = "lazy_backdrop",
    group = vim.api.nvim_create_augroup("lazynvim-fix", { clear = true }),
    callback = function(ctx)
        local win = vim.fn.win_findbuf(ctx.buf)[1]
        vim.api.nvim_win_set_config(win, { border = "none" })
    end,
})
