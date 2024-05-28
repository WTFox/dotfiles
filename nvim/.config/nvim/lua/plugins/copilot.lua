return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = {
      enabled = true,
    },
    filetypes = {
      markdown = true,
      help = true,
      text = false,
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          return false
        end
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.envrc.*") then
          return false
        end
        return true
      end,
    },
  },
}
