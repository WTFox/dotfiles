---@type PluginSpec
return {
    src = "MagicDuck/grug-far.nvim",
    config = function()
        require("grug-far").setup({
            -- Whether to show the prompt when picking a file
            show_prompt = true,
            -- Whether to open the file in a new tab
            open_in_new_tab = false,
        })
    end,
}
