require("neotest").setup({
  quickfix = {
    enabled = false,
  },
  output = {
    enabled = true,
    open_on_run = true,
  },
  output_panel = {
    enabled = true,
    open = "botright split | resize 15",
  },
  adapters = {
    require("neotest-python")({
      args = {
        "--create-db",
        "--nomigrations",
        "--ignore=node_modules",
      },
    }),
    require("neotest-jest")({
      command = "~/dev/health/node_modules/.bin/jest",
      args = {
        "--config=jest.config.js",
      },
      working_directory = "~/dev/health",
    }),
  },
})
