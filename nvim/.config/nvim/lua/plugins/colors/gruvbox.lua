return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      local cmds = {
        "let g:gruvbox_material_background = 'hard'",
        "let g:gruvbox_material_transparent_background = 2",
        "let g:gruvbox_material_diagnostic_line_highlight = 1",
        "let g:gruvbox_material_diagnostic_virtual_text = 'colored'",
        "let g:gruvbox_material_enable_bold = 1",
        "let g:gruvbox_material_enable_italic = 1",
      }

      for _, cmd in ipairs(cmds) do
        vim.cmd(cmd)
      end
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = false, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
}
