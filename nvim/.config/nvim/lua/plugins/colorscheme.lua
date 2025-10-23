return {
    -- Eagerly load default colorscheme
    { import = "plugins.colors.jellybeans" },
    -- Lazy load optional colorschemes
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            background = {
                light = "latte",
                dark = "frappe",
            },
            integrations = {
                diffview = true,
                telescope = { enabled = true, style = "nvchad" },
                mini = { enabled = true, indentscope_color = "lavender" },
                noice = true,
            },
        },
    },
    { import = "plugins.colors.kanagawa" },
    { import = "plugins.colors.vague" },
}
