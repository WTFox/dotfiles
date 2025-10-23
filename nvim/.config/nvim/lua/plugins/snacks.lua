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
                -- { title = "Recent ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
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
                    border = "rounded",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                },
                { win = "list", border = "none" },
            },
        },
        indent = { enabled = true },
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
            -- Live search optimization
            live = {
                limit = 5000,
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
        words = { enabled = true },
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
            -- show = {
            --     statusline = false,
            --     tabline = false,
            --     signcolumn = false,
            --     number = false,
            --     relativenumber = false,
            -- },
            -- toggles = {},
            win = {
                style = "zen",
                -- enter = true,
                -- fixbuf = false,
                -- minimal = true,
                -- width = 0,
                -- height = 0,
                -- backdrop = { transparent = false, blend = 40 },
                -- keys = { q = false },
                -- zindex = 40,
                -- wo = {
                --     winhighlight = "NormalFloat:Normal",
                -- },
                -- w = {
                --     snacks_main = true,
                -- },
            },
        },
    },
    keys = {
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
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
        -- find
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        {
            "<leader>po",
            function()
                local sessions_dir = require("mini.sessions").config.directory
                local sessions = {}
                local handle = vim.loop.fs_scandir(sessions_dir)
                if handle then
                    while true do
                        local name, type = vim.loop.fs_scandir_next(handle)
                        if not name then
                            break
                        end
                        if type == "file" and name:match("%.vim$") then
                            local session_name = name:gsub("%.vim$", "")
                            table.insert(sessions, session_name)
                        end
                    end
                end
                if #sessions == 0 then
                    print("No sessions found")
                    return
                end
                vim.ui.select(sessions, {
                    prompt = "Restore Session: ",
                }, function(choice)
                    if choice then
                        require("mini.sessions").read(choice .. ".vim")
                    end
                end)
            end,
            desc = "Open Project Session",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        -- git
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame",
        },
        {
            "<leader>ga",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git Stash",
        },
        {
            "<leader>gdd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>gdm",
            function()
                Snacks.picker.git_diff({ merge_base = true })
            end,
            desc = "Git Diff (vs Main Branch)",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log File",
        },
        -- Grep
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        -- search
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>s/",
            function()
                Snacks.picker.search_history()
            end,
            desc = "Search History",
        },
        {
            "<leader>sa",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Autocmds",
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sc",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>sC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>sD",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Buffer Diagnostics",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>sH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlights",
        },
        {
            "<leader>si",
            function()
                Snacks.picker.icons()
            end,
            desc = "Icons",
        },
        {
            "<leader>sj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>sl",
            function()
                Snacks.picker.loclist()
            end,
            desc = "Location List",
        },
        {
            "<leader>sm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>sM",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
        {
            "<leader>sp",
            function()
                Snacks.picker.lazy()
            end,
            desc = "Search for Plugin Spec",
        },
        {
            "<leader>sq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Quickfix List",
        },
        {
            "<leader>sR",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume",
        },
        {
            "<leader>su",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo History",
        },
        {
            "<leader>uC",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Colorschemes",
        },
        -- LSP
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "gai",
            function()
                Snacks.picker.lsp_incoming_calls()
            end,
            desc = "C[a]lls Incoming",
        },
        {
            "gao",
            function()
                Snacks.picker.lsp_outgoing_calls()
            end,
            desc = "C[a]lls Outgoing",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
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
            "<leader>td",
            function()
                Snacks.terminal("lazydocker", {
                    win = {
                        style = nil, -- Use floating window
                        backdrop = 85,
                        width = 0.9,
                        height = 0.9,
                    },
                })
            end,
            desc = "Open Lazydocker",
        },
        {
            "<leader>tc",
            function()
                Snacks.terminal("claude", {
                    win = {
                        style = nil, -- Use floating window
                        backdrop = 85,
                        width = 0.9,
                        height = 0.9,
                    },
                })
            end,
            desc = "Open Claude",
        },
        {
            "<leader>ty",
            function()
                Snacks.terminal("yazi", {
                    win = {
                        style = nil, -- Use floating window
                        backdrop = 85,
                        width = 0.9,
                        height = 0.9,
                    },
                })
            end,
            desc = "Open Yazi",
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
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
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

                -- Create some toggle mappings
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
                -- Dismiss notifications
                vim.keymap.set("n", "<leader>un", function()
                    Snacks.notifier.hide()
                end, { desc = "Dismiss Notifications" })
            end,
        })
    end,
}
