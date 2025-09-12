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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        local formatting = "lua vim.lsp.buf.format()"

        if ft == "lua" then
            formatting = "!stylua %"
        elseif ft == "tex" then
            formatting = "!latexindent -s -l -w %"
        end

        local cmd = function()
            vim.cmd("write")
            vim.cmd("silent " .. formatting)
        end

        map("n", "<leader>fo", cmd, { buffer = ev.buf })
    end,
})

-- Auto-format on save with LSP
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        if #clients > 0 then
            vim.lsp.buf.format({ bufnr = args.buf })
        end
    end,
})

-- Auto-reload buffers when focused
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})
