return {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {},
    keys = {
        {
            "<leader>uq",
            function()
                require("quicker").toggle()
            end,
            desc = "Toggle Quickfix",
        },
    },
}
