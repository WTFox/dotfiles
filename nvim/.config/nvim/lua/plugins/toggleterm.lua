local lazygit = nil
local lazydocker = nil

local float_opts = {
  border = "curved",
  winblend = 3,
  highlights = {
    border = "Normal",
    background = "Normal",
  },
}

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
    highlights = {
      -- Normal = {
      --   guibg = "<VALUE-HERE>",
      -- },
      NormalFloat = {
        -- link = 'Normal'
        guibg = "#11111b",
      },
      FloatBorder = {
        guifg = "#11111b",
        guibg = "#11111b",
      },
    },
    float_opts = float_opts,
  },
  keys = {
    { "<C-/>", "<cmd>ToggleTerm<CR>", desc = "Floating Terminal" },
    { "<leader>Ts", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Split Terminal" },
    {
      "<leader>gg",
      function()
        if lazygit == nil then
          lazygit = require("toggleterm.terminal").Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = float_opts,
          })
        end
        lazygit:toggle()
      end,
      desc = "LazyGit",
    },
    {
      "<leader>dd",
      function()
        if lazydocker == nil then
          lazydocker = require("toggleterm.terminal").Terminal:new({
            cmd = "lazydocker",
            hidden = true,
            direction = "float",
            float_opts = float_opts,
          })
        end
        lazydocker:toggle()
      end,
      desc = "LazyDocker",
    },
  },
}
