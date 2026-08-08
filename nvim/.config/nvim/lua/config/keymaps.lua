local map = vim.keymap.set

-- Helper function to merge opts with description
local function desc_opts(description, extra_opts)
    local merged = { desc = description, silent = true }
    if extra_opts then
        for k, v in pairs(extra_opts) do
            merged[k] = v
        end
    end
    return merged
end

map("n", "<space>", "<Nop>")

-- Movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", desc_opts("Move down (display line)", { expr = true }))
map("n", "k", "v:count == 0 ? 'gk' : 'k'", desc_opts("Move up (display line)", { expr = true }))
map("n", "<C-d>", "<C-d>zz", desc_opts("Half page down + center"))
map("n", "<C-u>", "<C-u>zz", desc_opts("Half page up + center"))

-- Window Navigation
map("n", "<C-l>", "<C-w>l", desc_opts("Move to right window"))
map("n", "<C-h>", "<C-w>h", desc_opts("Move to left window"))
map("n", "<C-j>", "<C-w>j", desc_opts("Move to bottom window"))
map("n", "<C-k>", "<C-w>k", desc_opts("Move to top window"))

-- Window Splits
map("n", "<leader>|", ":vsplit<CR>", desc_opts("Vertical split"))
map("n", "<leader>-", ":split<CR>", desc_opts("Horizontal split"))

-- Buffer Navigation
map("n", "L", ":bnext<CR>", desc_opts("Next buffer"))
map("n", "H", ":bprevious<CR>", desc_opts("Previous buffer"))
-- <leader>bd is provided by Snacks.nvim (Snacks.bufdelete())

-- File Operations
map("n", "<leader>q", "<cmd>q<CR>", desc_opts("Quit"))
map("n", "<leader>qq", "<cmd>qa!<CR>", desc_opts("Force Quit"))
map("n", "Q", "<cmd>q<CR>", desc_opts("Force quit"))
map("n", "<C-s>", ":w<CR>", desc_opts("Save file"))

-- quick yank line/paste/comment prev line
map("n", "yc", "yy:lua MiniComment.operator('n')<CR>p", desc_opts("Yank, paste, comment previous line"))

-- Copy/Paste
map("v", "<leader>p", '"_dP', desc_opts("Paste without overwriting register"))
map("x", "y", [["+y]], desc_opts("Copy to system clipboard"))

-- Indentation with persistent selection
map("v", "<", "<gv", desc_opts("Dedent and reselect"))
map("v", ">", ">gv", desc_opts("Indent and reselect"))

-- Terminal
map("t", "<Esc>", "<C-\\><C-N>", desc_opts("Exit terminal mode"))

-- Directory
map("n", "<leader>cd", function()
    vim.fn.chdir(vim.fn.expand("%:p:h"))
end, desc_opts("Change to current file's directory"))

-- Diff
map("n", "<leader>gD", "<cmd>windo diffthis<cr>", desc_opts("Diff Split"))

-- LSP keybinds for navigation are provided by Snacks.nvim
map("n", "<leader>cr", vim.lsp.buf.rename, desc_opts("Rename symbol"))

-- Diagnostics (picker versions are in snacks.lua as <leader>sd and <leader>sD)
map("n", "<leader>cD", vim.diagnostic.open_float, desc_opts("Open diagnostic float"))
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, desc_opts("Next diagnostic"))
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, desc_opts("Previous diagnostic"))

-- Lazy.nvim
map("n", "<leader>l", "<cmd>Lazy<CR>", desc_opts("Open Lazy"))

-- redraw / clear highlights
map("n", "<leader>ur", "<cmd>nohls<CR>", desc_opts("Clear search highlights"))

-- Formatting (<leader>uf / <leader>uF toggles are in snacks.lua, with the rest of <leader>u*)
map("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, desc_opts("Format buffer (all sources)"))

-- Undo tree (plugin spec + keys in lua/plugins/undotree.lua)
