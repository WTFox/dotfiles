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
                menu = {
                    draw = {
                        padding = { 0, 1 }, -- padding only on right side
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                                end,
                            },
                        },
                    },
                },
            },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
            sources = {
                default = {
                    "snippets",
                    "lsp",
                },
                providers = {
                    snippets = {
                        opts = {
                            friendly_snippets = true, -- default
                            -- frameworks:
                            -- https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
                            -- languages:
                            -- https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
                            extended_filetypes = {
                                markdown = { "jekyll" },
                                sh = { "shelldoc" },
                                php = { "phpdoc" },
                                cpp = { "unreal" },
                                python = { "django" },
                            },
                        },
                    },
                },
            },
        },
    },
}
