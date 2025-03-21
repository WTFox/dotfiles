return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        markdown = true,
        help = true,
        text = false,
        zsh = false,
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
  },
}
