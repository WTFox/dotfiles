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
        "--dbdriver=psycopg2",
        "--dbdriver=psycopg2cffi",
        "--dbdriver=redshift_connector",
      },
    }),
  },
})

-- disable format on save
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.b.autoformat = false
  end,
})
