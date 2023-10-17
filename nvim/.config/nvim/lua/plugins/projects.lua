require("which-key").register({
  p = { name = "Project" },
}, {
  prefix = "<leader>",
})

return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      show_hidden = true,
      silent_chdir = false,
      scope_chdir = "global",
    },
    keys = {
      { "<leader>po", "<Cmd>Telescope projects<CR>", desc = "Open Project" },
    },
  },
  {
    "windwp/nvim-projectconfig",
    opts = { silent = false },
    lazy = false,
    event = "VimEnter",
    keys = {
      { "<leader>pc", "<cmd>EditProjectConfig<cr>", desc = "Project Config" },
    },
  },
}
