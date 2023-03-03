require("nvim-test.runners.pytest"):setup({
  args = {
    "--dbdriver=psycopg2",
    "--dbdriver=psycopg2cffi",
    "--dbdriver=redshift_connector",
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.b.autoformat = false
  end,
})
