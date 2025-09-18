return {
    "cbochs/grapple.nvim",
    keys = function()
        local keys = {
            { "<leader>H", require("grapple").toggle, desc = "Toggle grapple tag" },
            { "<leader>h", require("grapple").open_tags, desc = "Open grapple tags" },
        }
        for i = 1, 9 do
            keys[#keys + 1] = { "<leader>" .. i, "<cmd>Grapple select index=" .. i .. "<cr>", desc = "Grapple select " .. i }
        end
        return keys
    end,
    opts = {
        icons = false,
    },
}
