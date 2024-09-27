return {
  "kelly-lin/ranger.nvim",
  keys = {
    {
      "<leader>fm",
      function()
        require("ranger-nvim").open(true)
      end,
      desc = "Ranger",
    },
  },
}
