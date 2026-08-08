local function pick(name, opts)
    return function()
        Snacks.picker[name](opts)
    end
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        dashboard = {
            enabled = true,
            project = true,
            formats = {
                key = function(item)
                    return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
                end,
            },
            sections = {
                { section = "keys", padding = 1 },
                { section = "recent_files", cwd = true, limit = 4, padding = 1 },
                { section = "startup" },
            },
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
            fullscreen = true,
            preview = true,
            layout = {
                backdrop = true,
                width = 40,
                min_width = 40,
                height = 0,
                position = "right",
                border = "none",
                box = "vertical",
                {
                    win = "input",
                    height = 1,
                    border = "none",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                },
                { win = "list", border = "none" },
            },
        },
        indent = { enabled = false },
        input = { enabled = true },
        lazygit = {
            enabled = true,
            win = {
                backdrop = 85,
                width = 0.9,
                height = 0.9,
                zindex = 100,
            },
        },
        notifier = { enabled = true, timeout = 3000 },
        picker = {
            enabled = true,
            layout = {
                preset = "ivy",
                preview = {
                    width = 0.6,
                    max_width = 120,
                },
            },
            win = {
                input = {
                    keys = {
                        ["<M-p>"] = { "toggle_preview", mode = { "i", "n" } },
                    },
                },
            },
            -- Git configuration with performance optimizations
            git = {
                extra_args = { "--no-optional-locks" },
            },
            sources = {
                explorer = {
                    layout = {
                        layout = { position = "right" },
                        -- Dynamic width based on column count
                        width = function()
                            return math.floor(vim.o.columns * 0.25)
                        end,
                    },
                    formatters = {
                        file = {
                            filename_first = true,
                            filename_only = false,
                        },
                    },
                    icons = {
                        files = {
                            enabled = true,
                        },
                    },
                },
            },
        },
        quickfile = { enabled = true },
        rename = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        terminal = {
            enabled = true,
            win = {
                style = "terminal",
                backdrop = 85,
                height = 0.4,
                zindex = 100,
                wo = {
                    winbar = "", -- Disable the title bar
                },
            },
            opts = {
                interactive = true, -- start_insert + auto_close + auto_insert
            },
        },
        zen = {
            win = { style = "zen" },
        },
    },
    keys = {
        { "<leader><space>", pick("smart"), desc = "Smart Find Files" },
        { "<leader>,", pick("buffers"), desc = "Buffers" },
        { "<leader>/", pick("grep"), desc = "Grep" },
        { "<leader>:", pick("command_history"), desc = "Command History" },
        {
            "<leader>D",
            function()
                Snacks.dashboard()
            end,
            desc = "Dashboard",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>E",
            function()
                Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
            end,
            desc = "File Explorer (buffer dir)",
        },
        -- find
        -- <leader>fb duplicated <leader>, (both Snacks.picker.buffers())
        { "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), desc = "Find Config File" },
        { "<leader>ff", pick("files"), desc = "Find Files" },
        { "<leader>fg", pick("git_files"), desc = "Find Git Files" },
        { "<leader>fp", pick("projects"), desc = "Projects" },
        -- <leader>po (open project session) is in lua/plugins/mini.lua, next to setup_sessions()
        { "<leader>fr", pick("recent"), desc = "Recent" },
        -- git
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame",
        },
        { "<leader>ga", pick("git_branches"), desc = "Git Branches" },
        { "<leader>gl", pick("git_log"), desc = "Git Log" },
        { "<leader>gL", pick("git_log_line"), desc = "Git Log Line" },
        { "<leader>gs", pick("git_status"), desc = "Git Status" },
        { "<leader>gS", pick("git_stash"), desc = "Git Stash" },
        -- <leader>gdd / <leader>gdm (full diff view) are owned by diffview.nvim
        { "<leader>gDd", pick("git_diff"), desc = "Git Diff (Hunks)" },
        { "<leader>gDm", pick("git_diff", { merge_base = true }), desc = "Git Diff (vs Main Branch)" },
        { "<leader>gf", pick("git_log_file"), desc = "Git Log File" },
        -- Grep
        { "<leader>sB", pick("grep_buffers"), desc = "Grep Open Buffers" },
        -- <leader>sg duplicated <leader>/ (both Snacks.picker.grep())
        { "<leader>sw", pick("grep_word"), desc = "Visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"', pick("registers"), desc = "Registers" },
        { "<leader>s/", pick("search_history"), desc = "Search History" },
        { "<leader>sa", pick("autocmds"), desc = "Autocmds" },
        { "<leader>sb", pick("lines"), desc = "Buffer Lines" },
        -- <leader>sc duplicated <leader>: (both Snacks.picker.command_history())
        { "<leader>sC", pick("commands"), desc = "Commands" },
        { "<leader>sd", pick("diagnostics"), desc = "Diagnostics" },
        { "<leader>sD", pick("diagnostics_buffer"), desc = "Buffer Diagnostics" },
        { "<leader>sh", pick("help"), desc = "Help Pages" },
        { "<leader>sH", pick("highlights"), desc = "Highlights" },
        { "<leader>si", pick("icons"), desc = "Icons" },
        { "<leader>sj", pick("jumps"), desc = "Jumps" },
        { "<leader>sk", pick("keymaps"), desc = "Keymaps" },
        { "<leader>sl", pick("loclist"), desc = "Location List" },
        { "<leader>sm", pick("marks"), desc = "Marks" },
        { "<leader>sM", pick("man"), desc = "Man Pages" },
        { "<leader>sp", pick("lazy"), desc = "Search for Plugin Spec" },
        { "<leader>sq", pick("qflist"), desc = "Quickfix List" },
        { "<leader>sR", pick("resume"), desc = "Resume" },
        { "<leader>su", pick("undo"), desc = "Undo History" },
        { "<leader>uC", pick("colorschemes"), desc = "Colorschemes" },
        -- LSP
        { "gd", pick("lsp_definitions"), desc = "Goto Definition" },
        { "gD", pick("lsp_declarations"), desc = "Goto Declaration" },
        { "grr", pick("lsp_references"), nowait = true, desc = "References" },
        { "gri", pick("lsp_implementations"), desc = "Goto Implementation" },
        { "grt", pick("lsp_type_definitions"), desc = "Goto T[y]pe Definition" },
        { "gai", pick("lsp_incoming_calls"), desc = "C[a]lls Incoming" },
        { "gao", pick("lsp_outgoing_calls"), desc = "C[a]lls Outgoing" },
        { "<leader>ss", pick("lsp_symbols"), desc = "LSP Symbols" },
        { "<leader>sS", pick("lsp_workspace_symbols"), desc = "LSP Workspace Symbols" },
        -- Other
        {
            "<leader>uz",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>uZ",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Toggle Zoom",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>ca",
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "Code Actions",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<C-\\>",
            function()
                Snacks.terminal.toggle()
            end,
            desc = "Toggle Terminal",
            mode = { "n", "t" },
        },
        {
            "<M-p>",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Toggle Terminal Zoom",
            mode = "t",
        },
        {
            "<C-[><C-[>",
            [[<C-\><C-n>]],
            desc = "Exit terminal mode",
            mode = "t",
        },
        -- ]] / [[ are owned by treesitter-textobjects (words = { enabled = false })
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        },
        {
            "<leader>n",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History",
        },
        -- gh
        { "<leader>gi", pick("gh_issue"), desc = "GitHub Issues (open)" },
        { "<leader>gI", pick("gh_issue", { state = "all" }), desc = "GitHub Issues (all)" },
        { "<leader>gp", pick("gh_pr"), desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", pick("gh_pr", { state = "all" }), desc = "GitHub Pull Requests (all)" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                -- Override print to use snacks for `:=` command
                if vim.fn.has("nvim-0.11") == 1 then
                    vim._print = function(_, ...)
                        dd(...)
                    end
                else
                    vim.print = _G.dd
                end

                -- All <leader>u* toggles live here
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
                Snacks.toggle.profiler():map("<leader>pp")
                Snacks.toggle.profiler_highlights():map("<leader>ph")

                vim.keymap.set("n", "<leader>uf", function()
                    if vim.b.disable_autoformat then
                        vim.b.disable_autoformat = false
                        print("Buffer auto-formatting on save enabled")
                    else
                        vim.b.disable_autoformat = true
                        print("Buffer auto-formatting on save disabled")
                    end
                end, { desc = "Toggle buffer auto-format on save" })

                vim.keymap.set("n", "<leader>uF", function()
                    if vim.g.disable_autoformat then
                        vim.g.disable_autoformat = false
                        vim.b.disable_autoformat = false -- also clear buffer-local flag to fully enable
                        print("Global auto-formatting on save enabled")
                    else
                        vim.g.disable_autoformat = true
                        print("Global auto-formatting on save disabled")
                    end
                end, { desc = "Toggle global auto-format on save" })

                -- Dismiss notifications
                vim.keymap.set("n", "<leader>un", function()
                    Snacks.notifier.hide()
                end, { desc = "Dismiss Notifications" })
            end,
        })
    end,
}
