-- Search Syntax
-- https://github.com/junegunn/fzf#search-syntax

return {
    "ibhagwan/fzf-lua",
    enabled = false,
    lazy = false,
    cmd = "FzfLua",
    keys = {
        { "grr", "<cmd>FzfLua lsp_references<CR>", desc = "Find references" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git status" },
        { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Document symbols" },
        { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
        { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
        { "<leader><leader>", "<cmd>FzfLua files<CR>", desc = "Find files" },
        { "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
        { "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
        { "<leader>/", "<cmd>FzfLua grep_curbuf<CR>", desc = "Search in buffer" },
        { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
        { "<leader>fs", "<cmd>FzfLua spell_suggest<CR>", desc = "Spelling suggestions" },
        { "<leader>sc", "<cmd>FzfLua commands<CR>", desc = "Commands" },
        { "<leader>sm", "<cmd>FzfLua marks<CR>", desc = "Marks" },
        { "<leader>st", "<cmd>FzfLua tabs<CR>", desc = "Tabs" },
        { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Search word under cursor" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
        { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Highlights" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jump list" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key mappings" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location list" },
        { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man pages" },
        { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix list" },
        {
            "<leader>fc",
            function()
                require("fzf-lua").git_files({ cwd = vim.fn.expand("~/dotfiles") })
            end,
            desc = "Find config files",
        },
        { "<leader>dl", "<cmd>FzfLua diagnostics_document<CR>", desc = "List diagnostics (document)" },
        { "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "List diagnostics (workspace)" },
        {
            "<leader>uC",
            function()
                require("fzf-lua").colorschemes({
                    winopts = { height = 0.6, width = 0.6 },
                    actions = {
                        ["default"] = function(selected)
                            vim.cmd("colorscheme " .. selected[1])
                            print("Colorscheme changed to: " .. selected[1])
                        end,
                    },
                })
            end,
            desc = "Choose colorscheme",
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
            end,
            desc = "Open project session",
        },
    },
    config = function()
        local actions = require("fzf-lua.actions")

        require("fzf-lua").setup({
            fzf_colors = true,
            fzf_opts = {
                ["--no-scrollbar"] = true,
            },
            defaults = {
                formatter = "path.dirname_first",
            },
            winopts = {
                height = 1,
                width = 1,
                backdrop = 85,
                preview = {
                    horizontal = "right:70%",
                },
            },
            files = {
                hidden = true,
                cwd_prompt = false,
                actions = {
                    ["ctrl-x"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["alt-i"] = actions.toggle_ignore,
                    ["alt-h"] = actions.toggle_hidden,
                },
            },
            oldfiles = {
                cwd_prompt = false,
            },
            git = {
                files = {
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
            },
            grep = {
                hidden = true,
                cwd_prompt = false,
                actions = {
                    ["alt-i"] = { actions.toggle_ignore },
                    ["alt-h"] = { actions.toggle_hidden },
                },
            },
            keymap = {
                builtin = {
                    ["<M-p>"] = "toggle-preview",
                },
                fzf = {
                    ["ctrl-a"] = "toggle-all",
                    ["ctrl-t"] = "first",
                    ["ctrl-g"] = "last",
                    ["ctrl-n"] = "down",
                    ["ctrl-p"] = "up",
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-d"] = "half-page-down",
                },
            },
            diagnostics = {
                signs = {
                    ["Error"] = { text = "", texthl = "DiagnosticSignError" },
                    ["Warn"] = { text = "", texthl = "DiagnosticSignWarn" },
                    ["Info"] = { text = "", texthl = "DiagnosticSignInfo" },
                    ["Hint"] = { text = "", texthl = "DiagnosticSignHint" },
                },
                multiline = 2,
            },
            previewers = {
                builtin = {
                    extensions = {
                        ["png"] = { "chafa", "{file}", "--format=symbols" },
                        ["jpg"] = { "chafa", "{file}", "--format=symbols" },
                        ["jpeg"] = { "chafa", "{file}", "--format=symbols" },
                        ["gif"] = { "chafa", "{file}", "--format=symbols" },
                        ["webp"] = { "chafa", "{file}", "--format=symbols" },
                    },
                },
            },
        })

        require("fzf-lua").register_ui_select()
    end,
}
