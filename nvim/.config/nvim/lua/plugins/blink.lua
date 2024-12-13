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
      completion = {
        enabled_providers = {
          "copilot",
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
    },
  },
}
