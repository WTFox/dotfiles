return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "haydenmeade/neotest-jest",
    "rouge8/neotest-rust",
  },
  opts = function(_, opts)
    opts.adapters = vim.list_extend(opts.adapters or {}, {
      require("neotest-go")({
        args = { "-tags=integration" },
      }),
      require("neotest-python")({}),
      require("neotest-jest")({}),
      require("neotest-rust")({
        args = { "--no-capture" },
        dap_adapter = "lldb",
      }),
    })
  end,
}
