return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slope",
        auto_toggle_bufferline = false,
      },
    },
    keys = {
      {
        "<leader>uB",
        function()
          if vim.opt.showtabline:get() == 2 then
            vim.opt.showtabline = 0
          else
            vim.opt.showtabline = 2
          end
        end,
        desc = "Toggle Bufferline",
      },
    },
  },
  {
    -- auto close buffers
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
