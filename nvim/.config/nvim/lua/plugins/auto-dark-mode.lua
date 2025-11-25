---@type LazySpec
return {
    "f-person/auto-dark-mode.nvim",
    enabled = false,
    config = function()
        require("auto-dark-mode").setup({
            set_dark_mode = function()
                vim.o.background = "dark"
                vim.cmd("colorscheme jellybeans")
            end,
            set_light_mode = function()
                vim.o.background = "light"
                vim.cmd("colorscheme catppuccin-latte")
            end,
            update_interval = 3000,
        })
    end,
}
