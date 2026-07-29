return {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
        { "DrKJeff16/wezterm-types", lazy = true },
        { "Bilal2453/luvit-meta", lazy = true },
    },
    opts = {
        library = {
            "wezterm-types",
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    },
}
