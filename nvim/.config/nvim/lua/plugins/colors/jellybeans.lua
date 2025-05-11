---@diagnostic disable-next-line: unused-local,unused-function
local set_oled = function(c)
  c.background = vim.o.background == "dark" and "#000000" or c.background
end

return {
  "wtfox/jellybeans.nvim",
  dev = true,
  opts = {
    transparent = false,
    italics = true,
    flat_ui = false,
    background = {
      dark = "jellybeans_mono",
      light = "jellybeans_mono_light",
    },
    on_colors = function(c) end,
    on_highlights = function(hl, c) end,
  },
}
