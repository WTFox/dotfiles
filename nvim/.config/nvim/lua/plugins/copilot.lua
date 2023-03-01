return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = { enabled = true },
        suggestion = { enabled = true, auto_trigger = true },
        filetypes = {
          python = true,
          javascript = true,
          typescript = true,
          rust = true,
          go = true,
        },
      })
    end,
  },
}
