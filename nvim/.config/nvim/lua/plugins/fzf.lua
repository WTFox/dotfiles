return {
    url = "https://github.com/ibhagwan/fzf-lua",
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
                formatter = "path.filename_first",
                cwd_prompt = false,
                actions = {
                    ["ctrl-x"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["alt-i"] = actions.toggle_ignore,
                    ["alt-h"] = actions.toggle_hidden,
                },
            },
            oldfiles = {
                formatter = "path.filename_first",
                cwd_prompt = false,
            },
            git = {
                files = {
                    formatter = "path.filename_first",
                    cwd_prompt = false,
                    actions = {
                        ["alt-i"] = { actions.toggle_ignore },
                        ["alt-h"] = { actions.toggle_hidden },
                    },
                },
            },
            grep = {
                actions = {
                    ["alt-i"] = { actions.toggle_ignore },
                    ["alt-h"] = { actions.toggle_hidden },
                },
            },
            keymap = {
                builtin = {
                    ["alt-p"] = "toggle-preview",
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
                multiline = true,
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
    end,
}
