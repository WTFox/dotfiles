return {
    "vieitesss/gh-permalink.nvim",
    enabled = false,
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
