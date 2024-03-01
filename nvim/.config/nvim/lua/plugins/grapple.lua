return {
  {
    "cbochs/grapple.nvim",
    -- if deleting this plugin, remove the reference in lualine.lua
    keys = {
      { "<leader>ha", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle" },
      { "<leader>hh", "<cmd>Grapple open_tags<cr>", desc = "Grapple list" },
      { "<C-S-1>", "<cmd>Grapple select index=1<CR>", desc = "Go to Grapple 1" },
      { "<C-S-2>", "<cmd>Grapple select index=2<CR>", desc = "Go to Grapple 2" },
      { "<C-S-3>", "<cmd>Grapple select index=3<CR>", desc = "Go to Grapple 3" },
      { "L", "<cmd>Grapple cycle_forward<cr>", desc = "Grapple next" },
      { "H", "<cmd>Grapple cycle_backward<cr>", desc = "Grapple prev" },
    },
  },
  {
    -- auto close buffers
    "axkirillov/hbac.nvim",
    config = true,
    opts = {
      autoclose = true, -- set autoclose to false if you want to close manually
      threshold = 5, -- hbac will start closing unedited buffers once that number is reached
      close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
      end,
      close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
      telescope = {
        -- See #telescope-configuration below
      },
    },
  },
}
