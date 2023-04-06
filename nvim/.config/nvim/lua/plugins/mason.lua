return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- golang
      "gopls",
      "revive",
      -- lua
      "stylua",
      -- python
      "black",
      "debugpy",
      "pylint",
      "pyright",
      -- shell
      "shellcheck",
      "shfmt",
      -- sql
      "sqlls",
      "sqlfluff",
      -- rust
      "rustfmt",
      "rust-analyzer",
      -- typescript
      "typescript-language-server",
    },
  },
}
