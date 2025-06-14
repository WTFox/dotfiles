return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>fm',
      mode = { 'n', 'v' },
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
    {
      -- Open in the current working directory
      '<leader>fM',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    -- {
    --   '<c-up>',
    --   '<cmd>Yazi toggle<cr>',
    --   desc = 'Resume the last yazi session',
    -- },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    yazi_floating_window_border = 'none',
    floating_window_scaling_factor = 1,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
