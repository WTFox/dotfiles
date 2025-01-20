return {
  "wtfox/jellybeans.nvim",
  -- dir = "~/dev/jellybeans.nvim",
  opts = {
    italics = false,
    -- on_colors = function(c)
    -- end,

    on_highlights = function(hl, c)
      -- change namespace colors to blue for golang
      hl["@lsp.type.namespace.go"] = {
        fg = c.morning_glory,
      }

      -- flat ui for snacks picker
      local prompt = c.mine_shaft
      hl.SnacksPickerBorder = {
        fg = c.background,
        bg = c.background,
      }
      hl.SnacksPickerInput = {
        fg = c.foreground,
        bg = prompt,
      }
      hl.SnacksPickerInputBorder = {
        fg = prompt,
        bg = prompt,
      }
      hl.SnacksPickerBoxBorder = {
        fg = prompt,
        bg = prompt,
      }
      hl.SnacksPickerBoxTitle = {
        fg = prompt,
        bg = c.koromiko,
      }
      hl.SnacksPickerTitle = {
        fg = c.foreground,
        bg = prompt,
      }
      hl.SnacksPickerList = {
        bg = prompt,
      }
      hl.SnacksPickerPrompt = {
        fg = c.koromiko,
        bg = prompt,
      }
      hl.SnacksPickerPreviewTitle = {
        fg = c.background,
        bg = c.biloba_flower,
      }
    end,
  },
}
