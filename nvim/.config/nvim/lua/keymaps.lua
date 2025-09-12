local map = vim.keymap.set
local opts = { silent = true }
local ns_opts = { noremap = true, silent = true }

map("n", "<space>", "<Nop>")

-- Movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Window Navigation
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- Window Splits
map("n", "<leader>|", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>", opts)

-- Buffer Navigation
map("n", "L", ":bnext<CR>", opts)
map("n", "H", ":bprevious<CR>", opts)
map("n", "<leader>bd", "<cmd>bdelete<CR>", opts)

-- File Operations
map("n", "<leader>w", "<cmd>w!<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "Q", "<cmd>q!<CR>", opts)
map("n", "<C-s>", ":w<CR>")

-- Tabs
map("n", "<leader>te", "<cmd>tabnew<CR>", opts)

-- Copy/Paste
map("v", "<leader>p", '"_dP')
map("x", "y", [["+y]], opts)

-- Terminal
map("t", "<Esc>", "<C-\\><C-N>")

-- Directory
map("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", ns_opts)
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", ns_opts)

-- Diagnostics
map("n", "<leader>dn", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", ns_opts)
map(
    "n",
    "<leader>dp",
    "<cmd>lua vim.diagnostic.jump({count = -1})<CR>",
    ns_opts
)
map("n", "<leader>dl", "<cmd>FzfLua diagnostics_document<CR>", ns_opts)
map("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", ns_opts)
map("n", "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", ns_opts)
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
end, ns_opts)

-- File Explorer
map("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>")
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

-- Fuzzy Finder
map("n", "grr", "<cmd>FzfLua lsp_references<CR>", ns_opts)
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", ns_opts)
map("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", ns_opts)
map("n", "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<CR>", ns_opts)
map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>")
map("n", "<leader><leader>", "<cmd>FzfLua files<CR>")
map("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>")
map("n", "<leader>sh", "<cmd>FzfLua help_tags<CR>")
map("n", "<leader>/", "<cmd>FzfLua grep_curbuf<CR>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>")
map("n", "<leader>sc", "<cmd>FzfLua commands<CR>")
map("n", "<leader>sm", "<cmd>FzfLua marks<CR>")
map("n", "<leader>st", "<cmd>FzfLua tabs<CR>")
map("n", "<leader>sw", "<cmd>FzfLua grep_cword<CR>")
map("n", "<leader>sC", "<cmd>FzfLua commands<cr>")
map("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>")
map("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>")
map("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>")
map("n", "<leader>sH", "<cmd>FzfLua highlights<cr>")
map("n", "<leader>sj", "<cmd>FzfLua jumps<cr>")
map("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>")
map("n", "<leader>sl", "<cmd>FzfLua loclist<cr>")
map("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>")
map("n", "<leader>sm", "<cmd>FzfLua marks<cr>")
map("n", "<leader>sR", "<cmd>FzfLua resume<cr>")
map("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>")
map("n", "<leader>fc", function()
    require("fzf-lua").git_files({ cwd = vim.fn.expand("~/dotfiles") })
end)
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
end)

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
    
    vim.api.nvim_echo({{ table.concat(lines, "\n"), "Normal" }}, true, {})
end)

-- Grapple
map("n", "<leader>H", require("grapple").toggle)
map("n", "<leader>h", require("grapple").open_tags)

-- Git
map({ "n", "x" }, "<leader>gy", require("gh-permalink").yank)
map("n", "<leader>ghp", function()
    require("gitsigns").preview_hunk()
end, ns_opts)
map("n", "<leader>ghb", function()
    require("gitsigns").blame_line()
end, ns_opts)
map("n", "<leader>ghr", function()
    require("gitsigns").reset_hunk()
end, ns_opts)
map("n", "<leader>gd", "<cmd>Git diffthis<CR>", ns_opts)

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
end, ns_opts)

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
end, ns_opts)

-- toggle line numbers
map("n", "<leader>ul", function()
    local has_numbers = vim.o.number or vim.o.relativenumber
    local new_state = not has_numbers

    -- Set for all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_set_option(buf, "number", new_state)
            vim.api.nvim_buf_set_option(buf, "relativenumber", new_state)
        end
    end

    -- Set global default for new buffers
    vim.o.number = new_state
    vim.o.relativenumber = new_state

    if new_state then
        print("Line numbers enabled")
    else
        print("Line numbers disabled")
    end
end, ns_opts)

-- redraw / clear highlights
map("n", "<leader>ur", "<cmd>nohls<CR>", ns_opts)
