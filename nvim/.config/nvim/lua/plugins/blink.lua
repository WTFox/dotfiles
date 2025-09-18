return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "1.*",
        lazy = true,
        event = "InsertEnter",
        opts = {
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
                default = {
                    -- "copilot",
                    "snippets",
                    "lsp",
                },
                providers = {
                    snippets = {
                        opts = {
                            friendly_snippets = true, -- default

                            -- see the list of frameworks in: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
                            -- and search for possible languages in: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
                            -- the following is just an example, you should only enable the frameworks that you use
                            extended_filetypes = {
                                markdown = { "jekyll" },
                                sh = { "shelldoc" },
                                php = { "phpdoc" },
                                cpp = { "unreal" },
                            },
                        },
                    },
                    -- copilot = {
                    --     name = "copilot",
                    --     module = "blink-copilot",
                    --     score_offset = 100,
                    --     async = true,
                    -- },
                },
            },
        },
    },
    -- {
    --     "fang2hou/blink-copilot",
    --     lazy = true,
    --     enabled = false,
    --     dependencies = {
    --         "saghen/blink.cmp",
    --     },
    --     event = "InsertEnter",
    -- },
}
