return {
    "wtfox/jellybeans.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
        transparent = false,
        italics = true,
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

            -- c.accent_color_1 = "#83adc3"
            -- c.accent_color_2 = "#c88a77"
            -- c.accent_color_2 = "#a98467"
            -- c.str = "#909c6e"
            -- c.background = vim.o.background == "dark" and "#101010" or c.background

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

            hl.RenderMarkdownH1Bg = { fg = c.perano }

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

            hl.Pmenu = { fg = "#dcd7ba", bg = "#223249" }
            hl.PmenuSel = { bg = "#2d4f67" }
            hl.PmenuSbar = { bg = "#223249" }
            hl.PmenuThumb = { bg = "#2d4f67" }
            hl.PmenuKind = { fg = "#c8c093", bg = "#223249" }
            hl.PmenuKindSel = { fg = "#c8c093", bg = "#2d4f67" }
            hl.PmenuExtra = { fg = "#7a8382", bg = "#223249" }
            hl.PmenuExtraSel = { fg = "#7a8382", bg = "#2d4f67" }

            -- Blink completion menu
            hl.BlinkCmpMenu = { fg = "#dcd7ba", bg = "#223249" }
            hl.BlinkCmpMenuSelection = { bg = "#2d4f67" }
            hl.BlinkCmpMenuBorder = { fg = "#223249", bg = "#223249" }
            hl.BlinkCmpScrollBarGutter = { bg = "#223249" }
            hl.BlinkCmpScrollBarThumb = { bg = "#2d4f67" }

            -- Labels and text
            hl.BlinkCmpLabel = { fg = "#dcd7ba" }
            hl.BlinkCmpLabelMatch = { fg = "#ffb454", bold = true }
            hl.BlinkCmpLabelDetail = { fg = "#7a8382" }
            hl.BlinkCmpLabelDescription = { fg = "#7a8382" }
            hl.BlinkCmpLabelDeprecated = { fg = "#7a8382", strikethrough = true }

            -- Kind icons
            hl.BlinkCmpKind = { fg = "#c8c093" }

            -- Ghost text (inline completion preview)
            hl.BlinkCmpGhostText = { fg = "#7a8382", italic = true }

            -- Source badges (LSP, Buffer, etc.)
            hl.BlinkCmpSource = { fg = "#c8c093", bold = true }

            -- Documentation window
            hl.BlinkCmpDoc = { fg = "#dcd7ba", bg = c.grey_three }
            hl.BlinkCmpDocBorder = { fg = c.shuttle_grey, bg = c.grey_three }
            hl.BlinkCmpDocSeparator = { fg = c.shuttle_grey }
            hl.BlinkCmpDocCursorLine = { bg = "#2d4f67" }

            -- Signature help
            hl.BlinkCmpSignatureHelp = { fg = "#dcd7ba", bg = c.grey_three }
            hl.BlinkCmpSignatureHelpBorder = { fg = c.shuttle_grey, bg = c.grey_three }
            hl.BlinkCmpSignatureHelpActiveParameter = { fg = "#ffb454", bold = true }
        end,
    },
}
