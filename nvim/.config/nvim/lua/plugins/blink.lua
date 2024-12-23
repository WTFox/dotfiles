return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "giuxtaposition/blink-cmp-copilot",
    },
  },
  opts = {
    sources = {
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
        },
      },
      default = {
        "copilot",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
    },
  },
}
