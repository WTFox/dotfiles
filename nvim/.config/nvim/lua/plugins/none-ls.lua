return {
  "nvimtools/none-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        -- nls.builtins.diagnostics.mypy,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.ruff,
        nls.builtins.diagnostics.tsc,
        nls.builtins.formatting.black,
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.sqlformat,
        nls.builtins.formatting.stylua,
        nls.builtins.code_actions.refactoring,
      },
    }
  end,
}
