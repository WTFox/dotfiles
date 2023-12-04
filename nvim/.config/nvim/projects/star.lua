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
        "--ignore=lib",
      },
    }),
  },
})

require("telescope").setup({ defaults = { file_ignore_patterns = { "lib/" } } })
