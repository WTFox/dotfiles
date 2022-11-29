require('nvim-test.runners.pytest'):setup {
  args = { "--create-db", "--nomigrations", "--ignore=node_modules", "--ignore=lib" },
}

require('telescope').setup { defaults = { file_ignore_patterns = { "lib" } } }
