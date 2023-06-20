local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
  float_opts = {
    width = 150,
    height = 40,
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _lazygit_toggle()
  lazygit:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = 20,
    hide_numbers = true,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm<CR>", desc = "Floating Terminal" },
    { "<leader>Ts", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Split Terminal" },
    { "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", desc = "LazyGit" },
  },
}
