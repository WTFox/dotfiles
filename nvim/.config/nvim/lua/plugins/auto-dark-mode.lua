---@type LazySpec
return {
    "f-person/auto-dark-mode.nvim",
    config = function()
        require("auto-dark-mode").setup({
            set_dark_mode = function()
                vim.o.background = "dark"
                vim.cmd("colorscheme " .. vim.g.dark_theme)
            end,
            set_light_mode = function()
                vim.o.background = "light"
                vim.cmd("colorscheme " .. vim.g.light_theme)
            end,
            update_interval = 3000,
        })
    end,
}
