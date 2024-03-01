return {
  {
    "cbochs/grapple.nvim",
    -- if deleting this plugin, remove the reference in lualine.lua
    keys = {
      { "<leader>ma", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle" },
      { "<leader>ml", "<cmd>Grapple open_tags<cr>", desc = "Grapple list" },
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
