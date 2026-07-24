-- Rust-inspired accent palette layered onto jellybeans_mono via on_colors/on_highlights.
local accents = {
    keyword = "#e19067", -- fn, let, mut, move, impl
    func = "#89a7ca", -- function/macro calls
    type_name = "#b7a8c4", -- trait/type identifiers
    number = "#c6abd3", -- numeric literals
    comment = "#747684", -- comments
    string = "#99ad6a", -- string literals
}

local function apply_accent_colors(c)
    c.background = "#060606"
    c.grey = accents.keyword -- drives Keyword/Statement
    c.accent_color_1 = accents.type_name -- drives Type/Constant
    c.accent_color_2 = accents.func -- drives Function/@function*
    c.scorpion = accents.comment -- drives Comment
    c.str = accents.string -- drives String/@string
end

local function on_colors(c)
    if vim.o.background == "dark" then
        apply_accent_colors(c)
    end
end

local function apply_syntax_highlights(hl, c)
    local punct = c.grey_chateau

    hl["@keyword"] = { fg = accents.keyword }
    hl["@keyword.function"] = { fg = accents.keyword }
    hl["@keyword.function.go"] = { fg = accents.keyword }
    hl["@type.builtin"] = { fg = accents.keyword }
    hl["@type.builtin.python"] = { fg = accents.keyword }
    hl["@function.macro"] = { fg = accents.func, bold = true }
    hl.Number = { fg = accents.number }
    hl.Operator = { fg = punct }
    hl["@punctuation.bracket"] = { fg = punct }
    hl["@punctuation.delimiter"] = { fg = punct }
    hl["@punctuation.special"] = { fg = punct }
end

local function apply_completion_menu_highlights(hl, c)
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
    hl.BlinkCmpDoc = { fg = "#dcd7ba", bg = c.bg }
    hl.BlinkCmpDocBorder = { fg = c.shuttle_grey, bg = c.bg }
    hl.BlinkCmpDocSeparator = { fg = c.shuttle_grey }
    hl.BlinkCmpDocCursorLine = { bg = "#2d4f67" }

    -- Signature help
    hl.BlinkCmpSignatureHelp = { fg = c.fg, bg = c.grey_three }
    hl.BlinkCmpSignatureHelpBorder = { fg = c.shuttle_grey, bg = c.grey_three }
    hl.BlinkCmpSignatureHelpActiveParameter = { fg = "#ffb454", bold = true }
end

local function on_highlights(hl, c)
    if vim.o.background == "dark" then
        apply_syntax_highlights(hl, c)
    end
    apply_completion_menu_highlights(hl, c)
end

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
            light = "jellybeans_hc_light",
        },
        on_colors = on_colors,
        on_highlights = on_highlights,
    },
}
