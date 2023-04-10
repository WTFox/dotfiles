return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-python",
    "haydenmeade/neotest-jest",
    "rouge8/neotest-rust",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
        require("neotest-jest"),
        require("neotest-rust"),
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test file" },
    { "<leader>tl", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
    { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
    {
      "<leader>tNF",
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      desc = "Debug File",
    },
    { "<leader>tNa", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
    { "<leader>tNs", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
  },
}
