return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
        options = {
            show_all_diags_on_cursorline = false,
            show_diags_only_under_cursor = true,
            show_source = { enabled = true },
            multilines = { enabled = true },
            add_messages = { display_count = true },
        },
    },
}
