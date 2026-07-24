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

-- Non-flat floats across this theme share one language (editor.lua's FloatBorder):
-- background matches the editor (c.background), definition comes from a visible
-- c.float_border edge, and selection reads via c.bright_grey (same as LspReference*).
-- These helpers apply that language to the native and Blink completion menus, and
-- route the "vibrant" accents onto the couple of spots that benefit from a pop:
-- fuzzy-match text, kind icons, source badges, and the active signature parameter.
local function apply_native_pmenu_highlights(hl, c)
    hl.Pmenu = { fg = c.foreground, bg = c.background }
    hl.PmenuSel = { bg = c.bright_grey }
    hl.PmenuSbar = { bg = c.background }
    hl.PmenuThumb = { bg = c.float_border }
    hl.PmenuKind = { fg = accents.func, bg = c.background }
    hl.PmenuKindSel = { fg = accents.func, bg = c.bright_grey }
    hl.PmenuExtra = { fg = c.grey_chateau, bg = c.background }
    hl.PmenuExtraSel = { fg = c.grey_chateau, bg = c.bright_grey }
end

local function apply_blink_highlights(hl, c)
    -- Menu
    hl.BlinkCmpMenu = { fg = c.foreground, bg = c.background }
    hl.BlinkCmpMenuBorder = { fg = c.float_border, bg = c.background }
    hl.BlinkCmpMenuSelection = { bg = c.bright_grey }
    hl.BlinkCmpScrollBarGutter = { bg = c.background }
    hl.BlinkCmpScrollBarThumb = { bg = c.float_border }

    -- Labels and text
    hl.BlinkCmpLabel = { fg = c.foreground }
    hl.BlinkCmpLabelMatch = { fg = accents.keyword, bold = true }
    hl.BlinkCmpLabelDetail = { fg = c.grey_chateau }
    hl.BlinkCmpLabelDescription = { fg = c.grey_chateau }
    hl.BlinkCmpLabelDeprecated = { fg = accents.comment, strikethrough = true }

    -- Kind icons and source badges
    hl.BlinkCmpKind = { fg = accents.func }
    hl.BlinkCmpSource = { fg = accents.type_name, bold = true }

    -- Ghost text (inline completion preview) - reuse Comment, already accent-driven
    hl.BlinkCmpGhostText = { link = "Comment" }

    -- Documentation window
    hl.BlinkCmpDoc = { fg = c.foreground, bg = c.background }
    hl.BlinkCmpDocBorder = { fg = c.float_border, bg = c.background }
    hl.BlinkCmpDocSeparator = { fg = c.float_border }
    hl.BlinkCmpDocCursorLine = { bg = c.bright_grey }

    -- Signature help
    hl.BlinkCmpSignatureHelp = { fg = c.foreground, bg = c.background }
    hl.BlinkCmpSignatureHelpBorder = { fg = c.float_border, bg = c.background }
    hl.BlinkCmpSignatureHelpActiveParameter = { fg = accents.number, bold = true }
end

local function on_highlights(hl, c)
    if vim.o.background == "dark" then
        apply_syntax_highlights(hl, c)
        apply_native_pmenu_highlights(hl, c)
        apply_blink_highlights(hl, c)
    end
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
