require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "--create-db", "--nomigrations", "--ignore=node_modules", "--ignore=lib" },
      runner = "pytest",
    }),

    require("neotest-jest")({
      command = "~/dev/health/node_modules/.bin/jest",
      args = { "--config=jest.config.js" },
    }),
  },
})

require("telescope").setup({ defaults = { file_ignore_patterns = { "lib" } } })
