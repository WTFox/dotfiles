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
            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    -- example custom sorting function, ensuring `_` entries are always last
                    function(a, b)
                        if (a.label:sub(1, 1) == "_") ~= (b.label:sub(1, 1) == "_") then
                            -- return true to sort `a` after `b`, and vice versa
                            return not (a.label:sub(1, 1) == "_")
                        end
                        -- nothing returned, fallback to the next sort
                    end,
                    "score", -- Primary sort: by fuzzy matching score
                    "sort_text", -- Secondary sort: by sortText field if scores are equal
                    "label", -- Tertiary sort: by label if still tied
                },
            },
            signature = { enabled = true },
            keymap = {
                preset = "enter",
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "normal",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                menu = {
                    auto_show = true,
                },
            },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = false } },
            },
            sources = {
                default = {
                    "lsp",
                    "snippets",
                    "buffer",
                    "path",
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
