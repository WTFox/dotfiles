local C = require("catppuccin.palettes").get_palette("mocha")
local O = require("catppuccin").options
local icons = require("lazyvim.config").icons

local catppuccin = {}
local transparent_bg = O.transparent_background and "NONE" or C.mantle

catppuccin.normal = {
  a = { bg = C.blue, fg = C.mantle, gui = "bold" },
  b = { bg = C.surface0, fg = C.blue },
  c = { bg = transparent_bg, fg = C.text },
}

catppuccin.insert = {
  a = { bg = C.green, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.green },
}

catppuccin.terminal = {
  a = { bg = C.green, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.green },
}

catppuccin.command = {
  a = { bg = C.peach, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.peach },
}

catppuccin.visual = {
  a = { bg = C.mauve, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.mauve },
}

catppuccin.replace = {
  a = { bg = C.red, fg = C.base, gui = "bold" },
  b = { bg = C.surface0, fg = C.red },
}

catppuccin.inactive = {
  a = { bg = transparent_bg, fg = C.blue },
  b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
  c = { bg = transparent_bg, fg = C.overlay0 },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = catppuccin,
      component_separators = "",
      -- slants
      section_separators = { left = "", right = "" },
      -- bubbles
      -- section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        function()
          return "󰣐 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
      },
      lualine_c = {},
      lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = LazyVim.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = LazyVim.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = LazyVim.ui.fg("Debug"),
          },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = LazyVim.ui.fg("Special"),
        },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
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
