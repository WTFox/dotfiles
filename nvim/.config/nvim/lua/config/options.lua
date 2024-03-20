-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- adds filename to top right of buffer
-- vim.opt.winbar = "%=%m %f"

-- disable auto pairs
vim.g.minipairs_disable = true

-- add highlighting to weird files
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".env.example"] = "sh",
    [".envrc"] = "sh",
    [".envrc.local"] = "sh",
    ["requirements.txt"] = "config",
    ["requirements-dev.txt"] = "config",
    ["requirements-test.txt"] = "config",
  },
})

-- vim.g.lazyvim_python_lsp = "basedpyright"
