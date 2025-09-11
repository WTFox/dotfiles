require("jellybeans").setup({
    transparent = false,
    italics = true,
    bold = true,
    flat_ui = true,
    plugins = "all",
    background = {
        dark = "jellybeans_mono",
        light = "jellybeans_muted_light",
    },
    on_colors = function(c)
        -- Coffee
        -- c.accent_color_1 = "#a98467"
        -- c.accent_color_2 = "#b7a88d"
        -- VSCode Darkish
        -- c.accent_color_1 = "#b5d4e3"
        -- c.accent_color_2 = "#b7a88d"
    end,
    on_highlights = function(hl, c) end,
})

vim.cmd.colorscheme("jellybeans")
