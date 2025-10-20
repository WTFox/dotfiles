return {
    "wtfox/jellybeans.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
        transparent = true,
        italics = false,
        bold = true,
        flat_ui = false,
        plugins = {
            all = true,
            auto = true,
        },
        background = {
            dark = "jellybeans_muted",
            light = "jellybeans_light",
        },
        on_colors = function(c)
            -- OLED mode
            -- c.background = vim.o.background == "dark" and "#000000" or c.background

            -- Coffee
            -- c.accent_color_1 = "#a98467"
            -- c.accent_color_2 = "#b7a88d"

            -- Rose Pine
            -- c.accent_color_1 = "#b89595"
            -- c.accent_color_2 = "#7a9085"
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

            hl.DiffViewDiffAdd = {
                fg = c.git.add.fg,
                bg = c.grey_three,
            }
            hl.DiffViewDiffDelete = {
                fg = c.git.delete.fg,
                bg = c.grey_three,
            }
            hl.DiffViewDiffChange = {
                fg = c.git.change.fg,
                bg = c.grey_three,
            }
            hl.DiffviewDiffText = {
                -- fg = c.info,
                bg = c.shuttle_grey,
            }

            hl.DiagnosticLineNumError = {
                fg = c.background,
                bg = c.diag.error,
            }

            hl.DiagnosticLineNumWarn = {
                fg = c.background,
                bg = c.diag.warning,
            }

            hl.Folded = {
                fg = c.ship_cove,
                bg = c.grey_three,
                italic = false,
                bold = false,
            }
        end,
    },
}
