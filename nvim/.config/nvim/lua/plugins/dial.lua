local function dial(fn)
    return function()
        return require("dial.map")[fn]()
    end
end

return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", dial("inc_normal"), expr = true, desc = "Increment" },
        { "<C-x>", dial("dec_normal"), expr = true, desc = "Decrement" },
        { "g<C-a>", dial("inc_gnormal"), expr = true, desc = "Increment" },
        { "g<C-x>", dial("dec_gnormal"), expr = true, desc = "Decrement" },
        { "<C-a>", dial("inc_visual"), mode = "v", expr = true, desc = "Increment" },
        { "<C-x>", dial("dec_visual"), mode = "v", expr = true, desc = "Decrement" },
        { "g<C-a>", dial("inc_gvisual"), mode = "v", expr = true, desc = "Increment" },
        { "g<C-x>", dial("dec_gvisual"), mode = "v", expr = true, desc = "Decrement" },
    },
    config = function()
        local augend = require("dial.augend")

        -- Note: only `default` is reachable — the keymaps above always call the
        -- bare inc/dec functions with no group argument.
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
        })
    end,
}
