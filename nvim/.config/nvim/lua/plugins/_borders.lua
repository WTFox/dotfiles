local border_style = "rounded"
return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = bordered(border_style),
          documentation = bordered(border_style),
        },
      })
    end,
  },
  {
    "which-key.nvim",
    opts = { window = { border = border_style } },
  },
  {
    "gitsigns.nvim",
    opts = { preview_config = { border = border_style } },
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      -- Set LspInfo border
      require("lspconfig.ui.windows").default_options.border = border_style
      return opts
    end,
  },
  {
    "null-ls.nvim",
    opts = { border = border_style },
  },
  {
    "mason.nvim",
    opts = {
      ui = { border = border_style },
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
