return {
    "wtfox/jellybeans.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
        transparent = false,
        italics = true,
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
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = false, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = { italic = true },
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = { -- add/modify theme and palette colors
                palette = {},
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                            -- bg = "#000000",
                            -- bg_dim = "#000000",
                        },
                    },
                    -- wave = { ui = { bg = "#101010" } },
                    dragon = { ui = { bg = "#101010" } },
                },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    -- Cursor line - darker for less contrast with dark background
                    CursorLine = { bg = "#1a1a1a" },
                    -- FzfLua
                    FzfLuaNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    FzfLuaBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    FzfLuaScrollBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    FzfLuaTitle = { fg = theme.ui.special, bold = true },
                    FzfLuaPromptNormal = { bg = theme.ui.bg_p1 },
                    FzfLuaPromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    FzfLuaListNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    FzfLuaListBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    FzfLuaResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    FzfLuaResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    FzfLuaPreviewNormal = { bg = theme.ui.bg_dim },
                    FzfLuaPreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                    -- Floating window hover details - match pmenu blue background
                    NormalFloat = { bg = theme.ui.bg_p1 },
                    FloatBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                }
            end,
            -- -- theme = "wave", -- Load "wave" theme when 'background' option is not set
            background = { -- map the value of 'background' option to a theme
                dark = "dragon", -- try "dragon" !
                light = "lotus",
            },
        },
    },
}
