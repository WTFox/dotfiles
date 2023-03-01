local wk = require("which-key")

wk.register({
  p = {
    name = "Project",
    c = { "<cmd>EditProjectConfig<cr>", "project config" },
  },
}, { prefix = "<leader>" })

return {
  "windwp/nvim-projectconfig",
  opts = {
    silent = false,
  },
}
