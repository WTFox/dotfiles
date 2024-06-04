---@module "tokyonight"

return {
  "folke/tokyonight.nvim",
  lazy = true,
  ---@type Config
  opts = {
    lualine_bold = true,
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    on_colors = function(colors)
      colors.border = colors.purple
      -- colors.bg = "#11111b"
      colors.bg = "#0e0e13"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    on_highlights = function(hl, c)
      local prompt = "#2d3149"
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = prompt,
      }
      hl.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.DashboardIcon = {
        fg = c.orange,
      }
      hl.DashboardDesc = {
        fg = c.fg_dark,
      }
      hl.DashboardFooter = {
        fg = c.magenta,
      }
      hl["@string.documentation.python"] = {
        fg = c.comment,
      }
    end,
  },
}
