require("jellybeans").setup({
    transparent = false,
    italics = true,
    bold = true,
    flat_ui = true,
    plugins = {
        all = false,
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
        hl.FzfLuaBorder = { fg = c.background, bg = c.background }
        -- Diagnostic line number colors
        hl.DiagnosticLineNrError = { fg = "#ff6c6b", bold = true }
        hl.DiagnosticLineNrWarn = { fg = "#ECBE7B", bold = true }
        hl.DiagnosticLineNrInfo = { fg = "#51afef", bold = true }
        hl.DiagnosticLineNrHint = { fg = "#98be65", bold = true }
    end,
})

vim.cmd.colorscheme("jellybeans")
