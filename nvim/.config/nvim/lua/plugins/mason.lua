return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
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
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end,
}
