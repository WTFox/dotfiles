return {
    "cbochs/grapple.nvim",
    lazy = true,
    opts = {
        icons = false,
    },
    keys = {
        {
            "<leader>H",
            function()
                require("grapple").toggle()
            end,
            desc = "Toggle grapple tag",
        },
        {
            "<leader>h",
            function()
                require("grapple").open_tags()
            end,
            desc = "Open grapple tags",
        },
    },
}
