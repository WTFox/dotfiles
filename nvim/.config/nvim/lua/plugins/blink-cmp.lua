---@type PluginSpec
return {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
    config = function()
        require("blink.cmp").setup({
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
            keymap = {
                preset = "super-tab",
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "normal",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
            sources = {
                default = { "copilot", "lsp" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
        })
    end,
}
