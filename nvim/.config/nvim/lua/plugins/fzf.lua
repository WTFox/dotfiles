return {
    url = "https://github.com/ibhagwan/fzf-lua",
    config = function()
        local actions = require("fzf-lua.actions")

        require("fzf-lua").setup({
            fzf_colors = true,
            fzf_opts = {
                ['--no-scrollbar'] = true,
            },
            defaults = {
                formatter = 'path.dirname_first'
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
                formatter = 'path.filename_first',
                cwd_prompt = false,
                actions = {
                    ["alt-i"] = { actions.toggle_ignore },
                    ["alt-h"] = { actions.toggle_hidden },
                },
            },
            oldfiles = {
                formatter = 'path.filename_first',
                cwd_prompt = false,
            },
            git = {
                files = {
                    formatter = 'path.filename_first',
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
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                    ["<C-i>"] = "toggle-preview",
                },
                fzf = {
                    ["ctrl-a"] = "toggle-all",
                    ["ctrl-t"] = "first",
                    ["ctrl-g"] = "last",
                },
            },
            actions = {
                files = {
                    ["ctrl-q"] = actions.file_sel_to_qf,
                    ["ctrl-n"] = actions.toggle_ignore,
                    ["ctrl-h"] = actions.toggle_hidden,
                    ["enter"] = actions.file_edit_or_qf,
                },
            },
            previewers = {
                builtin = {
                    extensions = {
                        ['png'] = { "chafa", "{file}", "--format=symbols" },
                        ['jpg'] = { "chafa", "{file}", "--format=symbols" },
                        ['jpeg'] = { "chafa", "{file}", "--format=symbols" },
                        ['gif'] = { "chafa", "{file}", "--format=symbols" },
                        ['webp'] = { "chafa", "{file}", "--format=symbols" },
                    },
                },
            },
        })
    end
}