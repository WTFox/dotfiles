local lspconfig = require("lspconfig")

lspconfig["pyright"].setup({
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
