local BORDER_STYLE = "rounded"

vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = true,
  float = {
    header = false,
    border = "rounded",
    focusable = true,
  },
})

return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = bordered(BORDER_STYLE),
          documentation = bordered(BORDER_STYLE),
        },
      })
    end,
  },
  {
    "which-key.nvim",
    opts = { window = { border = BORDER_STYLE } },
  },
  {
    "gitsigns.nvim",
    opts = { preview_config = { border = BORDER_STYLE } },
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      -- Set LspInfo border
      require("lspconfig.ui.windows").default_options.border = BORDER_STYLE
      return opts
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = { border = BORDER_STYLE },
  },
  {
    "mason.nvim",
    opts = {
      ui = { border = BORDER_STYLE },
    },
  },
  {
    "noice.nvim",
    opts = {
      presets = { lsp_doc_border = true },
    },
  },
  {
    "JellyApple102/flote.nvim",
    opts = {
      window_style = "minimal",
      window_border = "single",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
