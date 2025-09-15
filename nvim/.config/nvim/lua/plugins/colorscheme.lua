local local_dev = os.getenv("HOME") .. "/dev/nvim-plugins"

return {
    src = local_dev .. "/jellybeans.nvim",
    config = function()
        require("jellybeans").setup({
            transparent = false,
            italics = false,
            bold = true,
            flat_ui = true,
            plugins = {
                all = true,
                auto = true,
            },
            background = {
                dark = "jellybeans_muted",
                light = "jellybeans_light",
            },
            on_colors = function(c)
                -- Coffee
                -- c.accent_color_1 = "#a98467"
                -- c.accent_color_2 = "#b7a88d"
                -- VSCode Darkish
                -- c.accent_color_1 = "#b5d4e3"
                -- c.accent_color_2 = "#b7a88d"
            end,
            on_highlights = function(hl, c)
                -- FzfLua
                hl.FzfLuaBorder = { fg = c.background, bg = c.background }

                -- MiniStarter
                hl.MiniStarterHeader = { fg = c.error, bold = true }

                -- Unused variables
                hl.DiagnosticUnnecessary = {
                    fg = hl.Comment.fg,
                    italic = false,
                    underline = false,
                    undercurl = false,
                }
            end,
        })

        vim.cmd.colorscheme("jellybeans")
    end,
}
