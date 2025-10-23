local map = vim.keymap.set
local opts = { silent = true }
local ns_opts = { noremap = true, silent = true }

-- Helper function to merge opts with description
local function desc_opts(description, extra_opts)
    local merged = { desc = description }
    if extra_opts then
        for k, v in pairs(extra_opts) do
            merged[k] = v
        end
    end
    return merged
end

map("n", "<space>", "<Nop>")

-- Movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", desc_opts("Move down (display line)", { expr = true, silent = true }))
map("n", "k", "v:count == 0 ? 'gk' : 'k'", desc_opts("Move up (display line)", { expr = true, silent = true }))
map("n", "<C-d>", "<C-d>zz", desc_opts("Half page down + center"))
map("n", "<C-u>", "<C-u>zz", desc_opts("Half page up + center"))

-- Window Navigation
map("n", "<C-l>", "<C-w>l", desc_opts("Move to right window", opts))
map("n", "<C-h>", "<C-w>h", desc_opts("Move to left window", opts))
map("n", "<C-j>", "<C-w>j", desc_opts("Move to bottom window", opts))
map("n", "<C-k>", "<C-w>k", desc_opts("Move to top window", opts))

-- Window Splits
map("n", "<leader>|", ":vsplit<CR>", desc_opts("Vertical split", opts))
map("n", "<leader>-", ":split<CR>", desc_opts("Horizontal split", opts))
-- diff
map("n", "<leader>ds", "<cmd>windo diffthis<cr>", { desc = "Diff Split" })

-- Buffer Navigation
map("n", "L", ":bnext<CR>", desc_opts("Next buffer", opts))
map("n", "H", ":bprevious<CR>", desc_opts("Previous buffer", opts))
-- <leader>bd is provided by Snacks.nvim (Snacks.bufdelete())

-- File Operations
map("n", "<leader>q", "<cmd>q<CR>", desc_opts("Quit", opts))
map("n", "<leader>qq", "<cmd>qa!<CR>", desc_opts("Force Quit", opts))
map("n", "Q", "<cmd>q<CR>", desc_opts("Force quit", opts))
map("n", "<C-s>", ":w<CR>", desc_opts("Save file"))

-- quick yank line/paste/comment prev line
map("n", "yc", "yy:lua MiniComment.operator('n')<CR>p", { noremap = true, silent = true })

-- Copy/Paste
map("v", "<leader>p", '"_dP', desc_opts("Paste without overwriting register"))
map("x", "y", [["+y]], desc_opts("Copy to system clipboard", opts))

-- Indentation with persistent selection
map("v", "<", "<gv", desc_opts("Dedent and reselect"))
map("v", ">", ">gv", desc_opts("Indent and reselect"))

-- Terminal
map("t", "<Esc>", "<C-\\><C-N>", desc_opts("Exit terminal mode"))

-- Directory
map(
    "n",
    "<leader>cd",
    '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>',
    desc_opts("Change to current file's directory")
)

-- LSP keybinds for navigation are provided by Snacks.nvim
-- gd, gD, gr, gI, gy, gai, gao - See snacks.lua for full list
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc_opts("Rename symbol", ns_opts))

-- Diagnostics (picker versions are in snacks.lua as <leader>sd and <leader>sD)
map("n", "<leader>dn", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", desc_opts("Next diagnostic", ns_opts))
map("n", "<leader>dp", "<cmd>lua vim.diagnostic.jump({count = -1})<CR>", desc_opts("Previous diagnostic", ns_opts))
map("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", desc_opts("Open diagnostic float", ns_opts))

-- Jump to diagnostics with auto-popup
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
    vim.defer_fn(function()
        vim.diagnostic.open_float({ scope = "line" })
    end, 50)
end, desc_opts("Next diagnostic + show popup", ns_opts))

map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
    vim.defer_fn(function()
        vim.diagnostic.open_float({ scope = "line" })
    end, 50)
end, desc_opts("Previous diagnostic + show popup", ns_opts))


-- Lazy.nvim
map("n", "<leader>l", "<cmd>Lazy<CR>", desc_opts("Open Lazy"))

map("n", "<leader>R", function()
    -- Clear only our custom lua modules
    for name, _ in pairs(package.loaded) do
        if
            name:match("^keymaps")
            or name:match("^autocmds")
            or name:match("^plugins")
            or name:match("^plugin%-config")
            or name:match("^plugin%-loader")
            or name:match("^statusline")
            or name:match("^lsp")
            or name:match("^bootstrap")
        then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    -- Force colorscheme reload
    if vim.g.colors_name then
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end
    print("Config reloaded!")
end, desc_opts("Reload config"))

map("n", "<leader>up", function()
    local plugins = {}
    for name in pairs(package.loaded) do
        if not name:match("^_") and not name:match("^vim") and not name:match("^nvim") then
            table.insert(plugins, name)
        end
    end
    table.sort(plugins)

    local lines = { "Loaded Plugins:" }
    for _, plugin in ipairs(plugins) do
        table.insert(lines, "  " .. plugin)
    end

    vim.api.nvim_echo({ { table.concat(lines, "\n"), "Normal" } }, true, {})
end, desc_opts("Show loaded plugins"))

-- UI toggles are provided by Snacks.nvim
-- <leader>us  - Spelling
-- <leader>uw  - Wrap
-- <leader>uL  - Relative Number
-- <leader>ud  - Diagnostics
-- <leader>ul  - Line Numbers
-- <leader>uc  - Conceal Level
-- <leader>uT  - Treesitter
-- <leader>ub  - Dark Background
-- <leader>uh  - Inlay Hints
-- <leader>ug  - Indent Guides
-- <leader>uD  - Dim

-- redraw / clear highlights
map("n", "<leader>ur", "<cmd>nohls<CR>", desc_opts("Clear search highlights", ns_opts))

-- Formatting
map("n", "<leader>cf", function()
    -- Comprehensive formatting: conform + LSP + trailspace
    require("conform").format({ async = true, lsp_format = "fallback" })

    -- Also trim trailing whitespace and empty lines
    vim.defer_fn(function()
        if pcall(require, "mini.trailspace") then
            require("mini.trailspace").trim()
            require("mini.trailspace").trim_last_lines()
        end
    end, 100) -- Small delay to let formatting complete
end, desc_opts("Format buffer (all sources)", ns_opts))

map("n", "<leader>uf", function()
    if vim.b.disable_autoformat then
        vim.b.disable_autoformat = false
        print("Buffer auto-formatting on save enabled")
    else
        vim.b.disable_autoformat = true
        print("Buffer auto-formatting on save disabled")
    end
end, desc_opts("Toggle buffer auto-format on save", ns_opts))

map("n", "<leader>uF", function()
    if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        -- Also clear buffer-local flag to fully enable
        vim.b.disable_autoformat = false
        print("Global auto-formatting on save enabled")
    else
        vim.g.disable_autoformat = true
        print("Global auto-formatting on save disabled")
    end
end, desc_opts("Toggle global auto-format on save", ns_opts))

-- Undo tree
map("n", "<leader>fu", function()
    vim.cmd("packadd nvim.undotree")
    vim.cmd("Undotree")
end, desc_opts("Undo tree"))
