return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function()
            -- main branch: setup() only accepts install_dir
            -- ensure_installed is gone; call install() directly
            require("nvim-treesitter").install({
                "bash",
                "c",
                "css",
                "go",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "rust",
                "typescript",
                "vim",
                "vimdoc",
            })

            -- main branch: highlight auto-attach is gone; do it per FileType
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
                    if ok and stats and stats.size > max_filesize then
                        return
                    end
                    pcall(vim.treesitter.start, ev.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPre", "BufNewFile" },
        branch = "main",
        opts = {
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    -- ['@class.outer'] = '<c-v>', -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = false,
            },
        },
        keys = {
            {
                "]m",
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        { "@function.outer", "@class.outer" },
                        "textobjects"
                    )
                end,
                mode = { "n", "x", "o" },
            },
            {
                "[m",
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
                end,
                mode = { "n", "x", "o" },
            },
            {
                "]]",
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(
                        { "@class.outer", "@function.outer" },
                        "textobjects"
                    )
                end,
                mode = { "n", "x", "o" },
            },
            {
                "[[",
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start(
                        { "@class.outer", "@function.outer" },
                        "textobjects"
                    )
                end,
                mode = { "n", "x", "o" },
            },
            -- selections
            {
                "am",
                function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
                end,
                mode = { "x", "o" },
            },
            {
                "im",
                function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
                end,
                mode = { "x", "o" },
            },
            {
                "ac",
                function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
                end,
                mode = { "x", "o" },
            },
            {
                "ic",
                function()
                    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
                end,
                mode = { "x", "o" },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            enable = true,
            multiwindow = true,
            max_lines = 2,
            min_window_height = 0,
            line_numbers = false,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
        },
    },
}
