return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "mfussenegger/nvim-dap" },
  },
  opts = {
    tools = {
      inlay_hints = {
        auto = true,
        show_parameter_hints = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
      },
    },
  },
}
