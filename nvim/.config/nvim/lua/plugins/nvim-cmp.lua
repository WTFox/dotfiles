local ELLIPSIS_CHAR = "…"
local MIN_LABEL_WIDTH = 20
local MAX_LABEL_WIDTH = 20

return {
  "hrsh7th/nvim-cmp",
  opts = {
    formatting = {
      format = function(entry, vim_item)
        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
        elseif string.len(label) < MIN_LABEL_WIDTH then
          local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
          vim_item.abbr = label .. padding
        end
        return vim_item
      end,
    },
  },
}
