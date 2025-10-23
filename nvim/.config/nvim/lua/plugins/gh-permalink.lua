return {
    "vieitesss/gh-permalink.nvim",
    enabled = true,
    keys = {
        {
            "<leader>gy",
            function()
                require("gh-permalink").yank()
            end,
            mode = { "n", "x" },
            desc = "Yank GitHub permalink",
        },
    },
}
