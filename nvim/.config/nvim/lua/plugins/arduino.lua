local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = capabilities,
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "clangd" },
    },
  },
  {
    "edKotinsky/Arduino.nvim",
  },
}
