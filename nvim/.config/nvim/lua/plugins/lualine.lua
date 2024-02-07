return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {
        function()
          return "󰣐 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
      },
      lualine_z = {
        function()
          -- use %R for 24hr time
          local value = os.date("%I:%M %p") -- e.g. 01:36 PM
          return " " .. value
        end,
      },
    },
  },
}
