if true then
  return {}
end

local icons = require("lazyvim.config").icons

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = "",
      -- slants
      section_separators = { left = "", right = "" },
      -- bubbles
      -- section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      -- lualine_c = {},
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
      lualine_y = {
        -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
        -- { "location", padding = { left = 0, right = 1 } },
        -- { "filetype", padding = { left = 1, right = 1 } },
        { "encoding", padding = { left = 1, right = 1 } },
      },
      lualine_z = {
        { "location" },
        -- function()
        --   -- use %R for 24hr time
        --   local value = os.date("%I:%M %p") -- e.g. 01:36 PM
        --   return " " .. value
        -- end,
      },
    },
  },
}
