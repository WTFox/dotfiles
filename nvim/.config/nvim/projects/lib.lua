local lspconfig = require("lspconfig")

lspconfig["pyright"].setup({
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
  settings = {
    python = {
      analysis = {
        extraPaths = {
          os.getenv("HOME") .. "/dev/star/",
          os.getenv("HOME") .. "/dev/star/lib",
        },
      },
    },
  },
})
