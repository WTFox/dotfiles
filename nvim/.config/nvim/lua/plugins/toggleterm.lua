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
function LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local lazydocker = new_terminal("lazydocker", "float")
function LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

local ranger = new_terminal("ranger", "float")
function RANGER_TOGGLE()
  ranger:toggle()
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
    },
  },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm<CR>", desc = "Floating Terminal" },
    { "<leader>Ts", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Split Terminal" },
    { "<leader>gg", "<cmd>lua LAZYGIT_TOGGLE()<CR>", desc = "LazyGit" },
    { "<leader>dd", "<cmd>lua LAZYDOCKER_TOGGLE()<CR>", desc = "LazyDocker" },
  },
}
