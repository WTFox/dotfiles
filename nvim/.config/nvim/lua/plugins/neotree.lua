return {
    enabled = false,
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                })
            end,
            desc = "Explorer NeoTree (Reveal Current File)",
        },
        {
            "<leader>fE",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.uv.cwd(),
                })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
        { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        {
            "<leader>ge",
            function()
                require("neo-tree.command").execute({
                    source = "git_status",
                    toggle = true,
                })
            end,
            desc = "Git Explorer",
        },
        {
            "<leader>be",
            function()
                require("neo-tree.command").execute({
                    source = "buffers",
                    toggle = true,
                })
            end,
            desc = "Buffer Explorer",
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
            desc = "Start Neo-tree with directory",
            once = true,
            callback = function()
                if package.loaded["neo-tree"] then
                    return
                else
                    local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
                    if stats and stats.type == "directory" then
                        require("neo-tree")
                    end
                end
            end,
        })
    end,
    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = {
            "terminal",
            "trouble",
            "qf",
            "Outline",
        },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_hidden = false,
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
                        local sysname = vim.loop.os_uname().sysname
                        local open_cmd = sysname == "Darwin" and "open" or "xdg-open"
                        vim.fn.jobstart({ open_cmd, state.tree:get_node().path }, { detach = true })
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
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            git_status = {
                symbols = {
                    added = "",
                    modified = "",
                    deleted = "✖",
                    renamed = "󰁕",
                    untracked = "",
                    ignored = "",
                    unstaged = "󰄱",
                    staged = "󰱒",
                    conflict = "",
                },
            },
        },
    },
}
