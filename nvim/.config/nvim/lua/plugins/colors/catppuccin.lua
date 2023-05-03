return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 1,
    },
    no_italic = true, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
      comments = {},
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      mocha = {
        base = "#11111B",
      },
    },
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      neotest = true,
      nvimtree = true,
      telescope = true,
      notify = true,
      mini = true,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
}
