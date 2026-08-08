return {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        {
            "<leader>fu",
            function()
                require("undotree").toggle()
            end,
            desc = "Undo tree",
        },
    },
    opts = {},
}
