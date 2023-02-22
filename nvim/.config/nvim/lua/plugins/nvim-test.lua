local wk = require("which-key")

wk.register({
  t = {
    name = "test",
    t = { "<cmd>TestNearest<cr>", "test nearest" },
    f = { "<cmd>TestFile<cr>", "test file" },
  },
}, { prefix = "<leader>" })

return {
  "klen/nvim-test",
  config = function()
    require("nvim-test").setup()
  end,
}
