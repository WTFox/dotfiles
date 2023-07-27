local Terminal = require("toggleterm.terminal").Terminal

local new_terminal = function(cmd, direction)
  return Terminal:new({
    cmd = cmd,
    direction = direction,
    hidden = true,
    float_opts = {
      border = "curved",
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })
end

local lazygit = new_terminal("lazygit", "float")
function _lazygit_toggle()
  lazygit:toggle()
end

local lazydocker = new_terminal("lazydocker", "float")
function _lazydocker_toggle()
  lazydocker:toggle()
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
      winblend = 3,
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
    { "<leader>dd", "<cmd>lua _lazydocker_toggle()<CR>", desc = "LazyDocker" },
  },
}
