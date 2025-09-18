return {
    "MagicDuck/grug-far.nvim",
    opts = {
        show_prompt = true,
        open_in_new_tab = false,
    },
    keys = {
        {
            "<leader>sr",
            function()
                require("grug-far").open()
            end,
            desc = "Search and open file",
        },
    },
}
