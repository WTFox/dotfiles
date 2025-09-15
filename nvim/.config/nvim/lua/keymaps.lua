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
map(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    desc_opts("Move down (display line)", { expr = true, silent = true })
)
map(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    desc_opts("Move up (display line)", { expr = true, silent = true })
)
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

-- Buffer Navigation
map("n", "L", ":bnext<CR>", desc_opts("Next buffer", opts))
map("n", "H", ":bprevious<CR>", desc_opts("Previous buffer", opts))
map("n", "<leader>bd", "<cmd>bdelete<CR>", desc_opts("Delete buffer", opts))

-- File Operations
map("n", "<leader>w", "<cmd>w!<CR>", desc_opts("Force save", opts))
map("n", "<leader>q", "<cmd>q<CR>", desc_opts("Quit", opts))
map("n", "<leader>qq", "<cmd>qa!<CR>", desc_opts("Force Quit", opts))
map("n", "Q", "<cmd>q<CR>", desc_opts("Force quit", opts))
map("n", "<C-s>", ":w<CR>", desc_opts("Save file"))

-- Copy/Paste
map("v", "<leader>p", '"_dP', desc_opts("Paste without overwriting register"))
map("x", "y", [["+y]], desc_opts("Copy to system clipboard", opts))

-- Terminal
map("t", "<Esc>", "<C-\\><C-N>", desc_opts("Exit terminal mode"))

-- Directory
map(
    "n",
    "<leader>cd",
    '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>',
    desc_opts("Change to current file's directory")
)

-- LSP
map(
    "n",
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    desc_opts("Go to definition", ns_opts)
)
map(
    "n",
    "<leader>cr",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    desc_opts("Rename symbol", ns_opts)
)

-- Diagnostics
map(
    "n",
    "<leader>dn",
    "<cmd>lua vim.diagnostic.jump({count = 1})<CR>",
    desc_opts("Next diagnostic", ns_opts)
)
map(
    "n",
    "<leader>dp",
    "<cmd>lua vim.diagnostic.jump({count = -1})<CR>",
    desc_opts("Previous diagnostic", ns_opts)
)
map(
    "n",
    "<leader>dl",
    "<cmd>FzfLua diagnostics_document<CR>",
    desc_opts("List diagnostics (document)", ns_opts)
)
map(
    "n",
    "<leader>do",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    desc_opts("Open diagnostic float", ns_opts)
)
map(
    "n",
    "<leader>dw",
    "<cmd>FzfLua diagnostics_workspace<CR>",
    desc_opts("List diagnostics (workspace)", ns_opts)
)
map("n", "<leader>ud", function()
    local config = vim.diagnostic.config() or {}
    local enabled = config.signs ~= false
        or config.virtual_text ~= false
        or config.underline ~= false

    if enabled then
        vim.diagnostic.config({
            signs = false,
            virtual_text = false,
            underline = false,
        })
        print("Diagnostics disabled")
    else
        vim.diagnostic.config({
            signs = {
                linehl = {},
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
                    [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
                    [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
                },
            },
            virtual_text = {
                spacing = 4,
                prefix = "●",
                suffix = "",
                format = function(diagnostic)
                    return string.format("%s", diagnostic.message)
                end,
            },
            underline = false,
        })
        print("Diagnostics enabled")
    end
end, desc_opts("Toggle diagnostics", ns_opts))

-- Sessions
map("n", "<leader>po", function()
    local sessions_dir = require("mini.sessions").config.directory
    local sessions = {}

    -- Get all session files
    local handle = vim.loop.fs_scandir(sessions_dir)
    if handle then
        while true do
            local name, type = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            if type == "file" and name:match("%.vim$") then
                sessions[#sessions + 1] = name:gsub("%.vim$", "")
            end
        end
    end

    if #sessions == 0 then
        print("No sessions found")
        return
    end

    require("fzf-lua").fzf_exec(sessions, {
        prompt = "Sessions> ",
        actions = {
            ["default"] = function(selected)
                if selected and selected[1] then
                    require("mini.sessions").read(selected[1] .. ".vim")
                end
            end,
        },
    })
end, desc_opts("Open project session"))

map(
    "n",
    "<leader>ps",
    "<cmd>lua vim.pack.update()<CR>",
    desc_opts("Update packages")
)

-- Fuzzy Finder
map(
    "n",
    "grr",
    "<cmd>FzfLua lsp_references<CR>",
    desc_opts("Find references", ns_opts)
)
map(
    "n",
    "<leader>gs",
    "<cmd>FzfLua git_status<CR>",
    desc_opts("Git status", ns_opts)
)
map(
    "n",
    "<leader>ss",
    "<cmd>FzfLua lsp_document_symbols<CR>",
    desc_opts("Document symbols", ns_opts)
)
map(
    "n",
    "<leader>sS",
    "<cmd>FzfLua lsp_workspace_symbols<CR>",
    desc_opts("Workspace symbols", ns_opts)
)
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", desc_opts("Find files"))
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc_opts("Recent files"))
map("n", "<leader><leader>", "<cmd>FzfLua files<CR>", desc_opts("Find files"))
map("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc_opts("Live grep"))
map("n", "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc_opts("Help tags"))
map(
    "n",
    "<leader>/",
    "<cmd>FzfLua grep_curbuf<CR>",
    desc_opts("Search in buffer")
)
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", desc_opts("Find buffers"))
map("n", "<leader>sc", "<cmd>FzfLua commands<CR>", desc_opts("Commands"))
map("n", "<leader>sm", "<cmd>FzfLua marks<CR>", desc_opts("Marks"))
map("n", "<leader>st", "<cmd>FzfLua tabs<CR>", desc_opts("Tabs"))
map(
    "n",
    "<leader>sw",
    "<cmd>FzfLua grep_cword<CR>",
    desc_opts("Search word under cursor")
)
map("n", "<leader>sC", "<cmd>FzfLua commands<cr>", desc_opts("Commands"))
map(
    "n",
    "<leader>sd",
    "<cmd>FzfLua diagnostics_document<cr>",
    desc_opts("Document diagnostics")
)
map(
    "n",
    "<leader>sD",
    "<cmd>FzfLua diagnostics_workspace<cr>",
    desc_opts("Workspace diagnostics")
)
map("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc_opts("Help tags"))
map("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", desc_opts("Highlights"))
map("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", desc_opts("Jump list"))
map("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc_opts("Key mappings"))
map("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", desc_opts("Location list"))
map("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc_opts("Man pages"))
map("n", "<leader>sm", "<cmd>FzfLua marks<cr>", desc_opts("Marks"))
map(
    "n",
    "<leader>sR",
    "<cmd>FzfLua resume<cr>",
    desc_opts("Resume last search")
)
map("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc_opts("Quickfix list"))
map("n", "<leader>fc", function()
    require("fzf-lua").git_files({ cwd = vim.fn.expand("~/dotfiles") })
end, desc_opts("Find config files"))
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
        if
            not name:match("^_")
            and not name:match("^vim")
            and not name:match("^nvim")
        then
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

-- Grapple
map(
    "n",
    "<leader>H",
    require("grapple").toggle,
    desc_opts("Toggle grapple tag")
)
map(
    "n",
    "<leader>h",
    require("grapple").open_tags,
    desc_opts("Open grapple tags")
)

-- Git
map(
    { "n", "x" },
    "<leader>gy",
    require("gh-permalink").yank,
    desc_opts("Yank GitHub permalink")
)
map("n", "<leader>ghp", function()
    require("gitsigns").preview_hunk()
end, desc_opts("Preview hunk", ns_opts))
map("n", "<leader>ghb", function()
    require("gitsigns").blame_line()
end, desc_opts("Blame line", ns_opts))
map("n", "<leader>ghr", function()
    require("gitsigns").reset_hunk()
end, desc_opts("Reset hunk", ns_opts))
map("n", "<leader>gd", "<cmd>Git diffthis<CR>", desc_opts("Git diff", ns_opts))

-- UI
-- toggle background
map("n", "<leader>ub", function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
        print("Switched to light mode")
    else
        vim.o.background = "dark"
        print("Switched to dark mode")
    end
end, desc_opts("Toggle background", ns_opts))

-- inlay hints
map("n", "<leader>uh", function()
    if vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(false)
        print("Inlay hints disabled")
    else
        vim.lsp.inlay_hint.enable(true)
        print("Inlay hints enabled")
    end
end, desc_opts("Toggle background", ns_opts))

-- colorscheme picker
map("n", "<leader>uC", function()
    require("fzf-lua").colorschemes({
        winopts = {
            height = 0.6,
            width = 0.6,
        },
        actions = {
            ["default"] = function(selected)
                vim.cmd("colorscheme " .. selected[1])
                print("Colorscheme changed to: " .. selected[1])
            end,
        },
    })
end, desc_opts("Choose colorscheme", ns_opts))

-- toggle line wrapping
map("n", "<leader>uw", function()
    vim.o.wrap = not vim.o.wrap
    if vim.o.wrap then
        print("Line wrapping enabled")
    else
        print("Line wrapping disabled")
    end
end, desc_opts("Toggle line wrapping", ns_opts))

-- redraw / clear highlights
map(
    "n",
    "<leader>ur",
    "<cmd>nohls<CR>",
    desc_opts("Clear search highlights", ns_opts)
)
