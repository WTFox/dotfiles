require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "--create-db", "--nomigrations", "--ignore=node_modules" },
      runner = "pytest",
      python = "venv/bin/python",
    }),

    require("neotest-jest")({
      command = "~/dev/health/node_modules/.bin/jest",
      args = { "--config=jest.config.js" },
    }),
  },
})
