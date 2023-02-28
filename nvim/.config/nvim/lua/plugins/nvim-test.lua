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
    require("nvim-test").setup({
      silent = false, -- less notifications
      term = "toggleterm", -- a terminal to run ("terminal"|"toggleterm")
      termOpts = {
        direction = "float", -- terminal's direction ("horizontal"|"vertical"|"float")
        stopinsert = "auto", -- exit from insert mode (true|false|"auto")
        keep_one = true, -- keep only one terminal for testing
      },
    })
  end,
}
