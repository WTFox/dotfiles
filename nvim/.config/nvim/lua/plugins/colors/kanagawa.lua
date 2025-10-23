return {
    "rebelot/kanagawa.nvim",
    lazy = true,
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
}
