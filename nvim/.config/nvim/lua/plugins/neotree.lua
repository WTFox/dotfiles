return {
    -- dependencies
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    -- Neotree
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range("3"),
        config = function()
            -- Keymaps
            vim.keymap.set("n", "<leader>fe", function()
                require("neo-tree.command").execute({
                    toggle = true,
                    reveal_file = vim.fn.expand("%:p"),
                })
            end, { desc = "Explorer NeoTree (Reveal Current File)" })

            vim.keymap.set("n", "<leader>fE", function()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.uv.cwd(),
                })
            end, { desc = "Explorer NeoTree (cwd)" })

            vim.keymap.set(
                "n",
                "<leader>e",
                "<leader>fe",
                { desc = "Explorer NeoTree (Root Dir)", remap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>E",
                "<leader>fE",
                { desc = "Explorer NeoTree (cwd)", remap = true }
            )

            vim.keymap.set("n", "<leader>ge", function()
                require("neo-tree.command").execute({
                    source = "git_status",
                    toggle = true,
                })
            end, { desc = "Git Explorer" })

            vim.keymap.set("n", "<leader>be", function()
                require("neo-tree.command").execute({
                    source = "buffers",
                    toggle = true,
                })
            end, { desc = "Buffer Explorer" })

            require("neo-tree").setup({
                sources = { "filesystem", "buffers", "git_status" },
                open_files_do_not_replace_types = {
                    "terminal",
                    "trouble",
                    "qf",
                    "Outline",
                },
                filesystem = {
                    bind_to_cwd = false,
                    follow_current_file = { enabled = true, leave_dirs_open = true },
                    use_libuv_file_watcher = true,
                    filtered_items = {
                        visible = true, -- Show hidden files by default
                        hide_dotfiles = false,
                        hide_gitignored = true, -- Hide ignored files by default
                        hide_hidden = false, -- This is only relevant on Windows
                    },
                },
                window = {
                    position = "right",
                    mappings = {
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["<space>"] = "none",
                        ["."] = "toggle_hidden",
                        ["<M-i>"] = "toggle_gitignore",
                        ["Y"] = {
                            function(state)
                                local node = state.tree:get_node()
                                local path = node:get_id()
                                vim.fn.setreg("+", path, "c")
                            end,
                            desc = "Copy Path to Clipboard",
                        },
                        ["O"] = {
                            function(state)
                                require("lazy.util").open(
                                    state.tree:get_node().path,
                                    { system = true }
                                )
                            end,
                            desc = "Open with System Application",
                        },
                        ["P"] = {
                            "toggle_preview",
                            config = { use_float = true },
                        },
                    },
                },
                default_component_configs = {
                    indent = {
                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted = "✖", -- this can only be used in the git_status source
                            renamed = "󰁕", -- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored = "",
                            unstaged = "󰄱",
                            staged = "󰱒",
                            conflict = "",
                        },
                    },
                },
            })

            -- Auto-open on directory
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup(
                    "Neotree_start_directory",
                    { clear = true }
                ),
                desc = "Start Neo-tree with directory",
                once = true,
                callback = function()
                    if package.loaded["neo-tree"] then
                        return
                    else
                        local stats =
                            vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
                        if stats and stats.type == "directory" then
                            require("neo-tree")
                        end
                    end
                end,
            })
        end,
    },
}
