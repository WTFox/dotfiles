return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      python = { "ruff", { "black", "pylint", "flake8" } },
      javascript = { { "prettierd", "prettier" }, "eslint" },
      -- for all
      -- ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      -- ["_"] = { "trim_whitespace" },
    },
  },
}
