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
        config = function()
            -- main branch: nested config inside nvim-treesitter.configs is gone
            -- textobjects has its own setup + explicit keymaps
            local sel = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local km = vim.keymap.set

            -- select
            km({ "x", "o" }, "af", function() sel.select_textobject("@function.outer", "textobjects") end)
            km({ "x", "o" }, "if", function() sel.select_textobject("@function.inner", "textobjects") end)
            km({ "x", "o" }, "ac", function() sel.select_textobject("@class.outer", "textobjects") end)
            km({ "x", "o" }, "ic", function() sel.select_textobject("@class.inner", "textobjects") end)
            km({ "x", "o" }, "al", function() sel.select_textobject("@loop.outer", "textobjects") end)
            km({ "x", "o" }, "il", function() sel.select_textobject("@loop.inner", "textobjects") end)
            km({ "x", "o" }, "aa", function() sel.select_textobject("@parameter.outer", "textobjects") end)
            km({ "x", "o" }, "ia", function() sel.select_textobject("@parameter.inner", "textobjects") end)
            km({ "x", "o" }, "as", function() sel.select_textobject("@statement.outer", "textobjects") end)

            -- move
            km({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
            km({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end)
            km({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
            km({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end)
            km({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
            km({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end)
            km({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
            km({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end)

            -- swap
            km("n", "<leader>a", function() swap.swap_next("@parameter.inner", "textobjects") end)
            km("n", "<leader>A", function() swap.swap_previous("@parameter.inner", "textobjects") end)
        end,
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
