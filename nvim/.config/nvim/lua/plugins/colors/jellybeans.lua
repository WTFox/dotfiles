return {
    "wtfox/jellybeans.nvim",
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
        transparent = false,
        italics = false,
        bold = false,
        flat_ui = false,
        plugins = {
            all = true,
            auto = true,
        },
        background = {
            dark = "jellybeans_mono",
            light = "jellybeans_mono_light",
        },
        on_colors = function(c)
            -- Dark mode: amber + green - retro terminal vibes
            if vim.o.background == "dark" then
                c.accent_color_1 = "#7a9fb0" -- dusty slate blue for types
                c.accent_color_2 = "#d59455" -- warm terracotta for functions
                c.str = "#6ba84f" -- muted sage green for strings
                c.background = "#101010"
            else
                -- Light mode: inspired by Studio98 - clean, high contrast
                c.accent_color_1 = "#0030c0" -- darker blue for types
                c.accent_color_2 = "#d47a1f" -- darker orange for functions
                c.str = "#1a4a0f" -- darker sage green for strings
                -- Keep jellybeans_light background which is likely #f5f5f5
            end
        end,
        on_highlights = function(hl, c)
            hl.NormalFloat = hl.Normal

            -- Light mode keyword and comment colors
            if vim.o.background == "light" then
                hl.Keyword = { fg = "#0048ff" }
                hl.Comment = { fg = "#666666" }
            end

            hl.RenderMarkdownH1Bg = { fg = c.perano }
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
            hl.CursorLineNr = {
                fg = vim.o.background == "dark" and "#d59455" or "#223249",
            }

            -- hl.Pmenu = { fg = "#dcd7ba", bg = "#223249" }
            -- hl.PmenuSel = { bg = "#2d4f67" }
            -- hl.PmenuSbar = { bg = "#223249" }
            -- hl.PmenuThumb = { bg = "#2d4f67" }
            -- hl.PmenuKind = { fg = "#c8c093", bg = "#223249" }
            -- hl.PmenuKindSel = { fg = "#c8c093", bg = "#2d4f67" }
            -- hl.PmenuExtra = { fg = "#7a8382", bg = "#223249" }
            -- hl.PmenuExtraSel = { fg = "#7a8382", bg = "#2d4f67" }
            --
            -- -- Blink completion menu
            -- hl.BlinkCmpMenu = { fg = "#dcd7ba", bg = "#223249" }
            -- hl.BlinkCmpMenuSelection = { bg = "#2d4f67" }
            -- hl.BlinkCmpMenuBorder = { fg = "#223249", bg = "#223249" }
            -- hl.BlinkCmpScrollBarGutter = { bg = "#223249" }
            -- hl.BlinkCmpScrollBarThumb = { bg = "#2d4f67" }
            --
            -- -- Labels and text
            -- hl.BlinkCmpLabel = { fg = "#dcd7ba" }
            -- hl.BlinkCmpLabelMatch = { fg = "#ffb454", bold = true }
            -- hl.BlinkCmpLabelDetail = { fg = "#7a8382" }
            -- hl.BlinkCmpLabelDescription = { fg = "#7a8382" }
            -- hl.BlinkCmpLabelDeprecated = { fg = "#7a8382", strikethrough = true }
            --
            -- -- Kind icons
            -- hl.BlinkCmpKind = { fg = "#c8c093" }
            --
            -- -- Ghost text (inline completion preview)
            -- hl.BlinkCmpGhostText = { fg = "#7a8382", italic = true }
            --
            -- -- Source badges (LSP, Buffer, etc.)
            -- hl.BlinkCmpSource = { fg = "#c8c093", bold = true }
            --
            -- -- Documentation window
            -- hl.BlinkCmpDoc = { fg = "#dcd7ba", bg = c.bg }
            -- hl.BlinkCmpDocBorder = { fg = c.shuttle_grey, bg = c.bg }
            -- hl.BlinkCmpDocSeparator = { fg = c.shuttle_grey }
            -- hl.BlinkCmpDocCursorLine = { bg = "#2d4f67" }

            -- Signature help
            -- hl.BlinkCmpSignatureHelp = { fg = c.fg, bg = c.grey_three }
            -- hl.BlinkCmpSignatureHelpBorder = { fg = c.shuttle_grey, bg = c.grey_three }
            -- hl.BlinkCmpSignatureHelpActiveParameter = { fg = "#ffb454", bold = true }
        end,
    },
}
