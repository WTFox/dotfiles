return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {
        function()
          return "♥ " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
      },
      lualine_z = {
        function()
          local value = os.date("%I:%M %p") -- e.g. 01:36 PM
          -- local value = os.date("%R") -- e.g. 13:36
          return " " .. value
        end,
      },
    },
  },
}
