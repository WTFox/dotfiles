require('nvim-test.runners.pytest'):setup {
  args = { "--create-db", "--nomigrations", "--ignore=node_modules" },
  env = { ENVIRONMENT = "dev" }
}
