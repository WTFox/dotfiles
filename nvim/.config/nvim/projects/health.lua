require("nvim-test.runners.pytest"):setup({
  args = {
    "--create-db",
    "--nomigrations",
    "--ignore=node_modules",
  },
  env = {
    ENVIRONMENT = "dev",
    DB_DEFAULT_HOST = "localhost",
  },
})

require("nvim-test.runners.jest"):setup({
  command = "~/dev/health/node_modules/.bin/jest",
  args = {
    "--config=jest.config.js",
  },
  env = {
    ENVIRONMENT = "dev",
  },
  working_directory = "~/dev/health",
})
