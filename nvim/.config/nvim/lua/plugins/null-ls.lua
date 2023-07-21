local nls = require("null-ls")

return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = {
    sources = {
      nls.builtins.formatting.prettier,
      nls.builtins.diagnostics.mypy,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.black,
      nls.builtins.formatting.sqlformat,
      nls.builtins.formatting.shfmt,
    },
  },
}
