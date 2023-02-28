require("nvim-test.runners.pytest"):setup({
  args = {
    "--dbdriver=psycopg2",
    "--dbdriver=psycopg2cffi",
    "--dbdriver=redshift_connector",
  },
})
