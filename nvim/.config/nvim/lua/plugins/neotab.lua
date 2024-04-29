return {
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "<Tab>",
      act_as_tab = true,
      behavior = "nested", ---@type ntab.behavior
      pairs = { ---@type ntab.pair[]
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "<", close = ">" },
      },
      exclude = {},
      smart_punctuators = {
        enabled = false,
        semicolon = {
          enabled = false,
          ft = { "cs", "c", "cpp", "java" },
        },
        escape = {
          enabled = true,
          triggers = {
            [","] = {
              pairs = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
              },
              format = "%s ", -- ", "
            },
            ["="] = {
              pairs = {
                { open = "(", close = ")" },
              },
              ft = { "javascript", "typescript" },
              format = " %s> ", -- ` => `
              -- string.match(text_between_pairs, cond)
              cond = "^$", -- match only pairs with empty content
            },
          },
        },
      },
    },
  },
}
