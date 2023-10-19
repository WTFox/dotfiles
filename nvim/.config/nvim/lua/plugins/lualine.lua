return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
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
