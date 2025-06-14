-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  if f ~= "global.lua" then
    local server_name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(lsp_configs, server_name)
  end
end
vim.lsp.enable(lsp_configs)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("global.lsp", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    local utils = require("utils")

    utils.set_keymap({
      key = "gd",
      cmd = ":lua require('snacks.picker').lsp_definitions()<cr>",
      desc = "Go to definition",
      bufnr = bufnr,
    })

    utils.set_keymap({
      key = "gr",
      cmd = ":lua require('snacks.picker').lsp_references()<cr>",
      desc = "Go to references",
      bufnr = bufnr,
    })
  end,
})
