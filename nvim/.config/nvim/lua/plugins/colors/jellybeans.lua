---@diagnostic disable-next-line: unused-local,unused-function
local set_oled = function(c)
  c.background = vim.o.background == "dark" and "#000000" or c.background
end

return {
  "wtfox/jellybeans.nvim",
  dev = true,
  opts = {
    transparent = false,
    italics = false,
    flat_ui = false,
    background = {
      dark = "jellybeans_mono",
      light = "jellybeans_mono_light",
    },
    on_colors = function(c)
      -- Coffee
      -- c.accent_color_1 = "#a98467"
      -- c.accent_color_2 = "#b7a88d"

      -- VSCode Darkish
      -- c.accent_color_1 = "#b5d4e3"
      -- c.accent_color_2 = "#b7a88d"
    end,
    on_highlights = function(hl, c) end,
  },
}
