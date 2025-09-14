return {
    url = "https://github.com/monaqa/dial.nvim",
    config = function()
        local augend = require("dial.augend")

        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%m/%d/%Y"],
                augend.date.alias["%d/%m/%Y"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%-m/%-d"],
                augend.date.alias["%Y年%-m月%-d日"],
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "&&", "||" },
                    word = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                }),
                augend.semver.alias.semver,
                augend.constant.new({
                    elements = { "let", "const" },
                    word = true,
                    cyclic = true,
                }),
            },

            typescript = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.new({
                    elements = { "let", "const" },
                    word = true,
                    cyclic = true,
                }),
            },

            vue = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.new({
                    elements = { "let", "const" },
                    word = true,
                    cyclic = true,
                }),
                augend.hexcolor.new({
                    case = "lower",
                }),
            },

            css = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.hexcolor.new({
                    case = "lower",
                }),
            },

            markdown = {
                augend.integer.alias.decimal,
                augend.misc.alias.markdown_header,
                augend.constant.new({
                    elements = { "[ ]", "[x]" },
                    word = false,
                    cyclic = true,
                }),
            },

            json = {
                augend.integer.alias.decimal,
                augend.semver.alias.semver,
            },

            lua = {
                augend.integer.alias.decimal,
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),
            },

            python = {
                augend.integer.alias.decimal,
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                }),
            },
        })

        vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
        vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
        vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
        vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
        vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
        vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
        vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
        vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end
}