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
    -- for i = 1, 9 do
    --     keys[#keys + 1] =
    --         { "<leader>" .. i, "<cmd>Grapple select index=" .. i .. "<cr>", desc = "Grapple select " .. i }
    -- end
    -- return keys
}
