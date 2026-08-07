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
            dark = "jellybeans_muted",
            light = "jellybeans_muted_light",
        },
    },
}
