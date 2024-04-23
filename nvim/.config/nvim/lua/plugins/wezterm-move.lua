return {
  "letieu/wezterm-move.nvim",
  keys = {
    {
      "<C-;>",
      function()
        require("wezterm-move").move("j")
      end,
    },
  },
}
