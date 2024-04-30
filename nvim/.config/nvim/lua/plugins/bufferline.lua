local utils = require("lazyvim.util")

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      separator_style = "slope",
      auto_toggle_bufferline = false,
    },
  },
  keys = {
    {
      "<leader>uB",
      function()
        utils.toggle.option("showtabline", false, { 2, 0 })
      end,
      desc = "Toggle Bufferline",
    },
  },
}
