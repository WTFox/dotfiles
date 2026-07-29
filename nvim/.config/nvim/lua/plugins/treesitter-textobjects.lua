return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    branch = "main",
    opts = {
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
            },
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
                require("nvim-treesitter-textobjects.move").goto_previous_start(
                    { "@function.outer", "@class.outer" },
                    "textobjects"
                )
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
}
